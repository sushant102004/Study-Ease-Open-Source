const mongoose = require('mongoose')
const validatorJS = require('validator')
const bcrypt = require('bcryptjs')
const nodemailer = require('nodemailer')
// const mailgun = require('mailgun-js')

const userSchema = mongoose.Schema({
    name: {
        type: String,
        trim: true,
        minLength: 2,
        maxLength: 25,
    },

    email: {
        type: String,
        required: [true, 'Email is required'],
        trim: true,
        validate: {
            validator: function(value){
                return validatorJS.isEmail(value)
            },
            message: 'Email is invalid.'
        },
        unique: true,
    },

    password: {
        type: String,
        required: [true, 'Password is required'],
        minLength: 8,
        maxLength: 30,
        select: false
    },
    
    passwordChangedAt: Date,
    OTP: Number,
    accountStatus: {
        type: String,
        enum: ['active', 'pending', 'pendingCompletion', 'disabled'],
        default: 'pending',
    },
    createdAt: {
        type: Date,
        default: Date.now()
    },
    phoneNumber: {
        type: Number,
        trim: true
    },
    college: {
        type: String,
        trim: true,
    },
    isAdmin: {
        type: Boolean,
        default: false,
    }
})

userSchema.pre('save', async function(next){
    if(!this.isModified('password')) return next()

    this.password = await bcrypt.hash(this.password, 12)

    let OTP = Math.floor(1000 + Math.random() * 9000)

    this.OTP = OTP
    next()
})

userSchema.methods.verifyOTP = async function(enteredOTP, OTPInDB) {
    return await enteredOTP === OTPInDB
}

userSchema.methods.checkPassword = async function(enteredPassword) {
    return await bcrypt.compare(enteredPassword, this.password)
}

userSchema.methods.createPasswordResetOTP = async function(){
    let OTP = Math.floor(1000 + Math.random() * 9000)
    this.OTP = OTP
}

userSchema.methods.resetOTP = async function() {
    this.OTP = undefined
}

const User = new mongoose.model('User', userSchema)

module.exports = {User}