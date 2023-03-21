const jwt = require('jsonwebtoken')
const { User } = require('../models/userModel')
const CustomError = require('../utils/CustomError')
const nodemailer = require('nodemailer')
const dotenv = require('dotenv')

dotenv.config()



const getUserFromToken = async (req, res, next) => {
    const authToken = await req.headers.authorization.split(' ')[1]
    if(!authToken) {
        return next(new CustomError('Auth token not found.', 404))
    }
    const decoded = jwt.verify(authToken, process.env.JWT_SECRET)

    const user = await User.findOne({ _id : decoded.id })
    if(!user){
        return next(new CustomError('User not found.', 404))
    }
    return user
}

exports.signUp = async (req, res, next) => {
    try {
        const newUser = await User.create({
            email: req.body.email,
            password: req.body.password
        })

        const token =  jwt.sign({ id : newUser._id}, process.env.JWT_SECRET)

        async function sendMail(){
            const transporter = nodemailer.createTransport({
                host: 'smtp.mailgun.org',
                port : 587,
                secure: false,
                auth : {
                    user : process.env.MAILGUN_USER,
                    pass : process.env.MAILGUN_PASSWORD
                }
            })
    
            let info = await transporter.sendMail({
                from: 'sushant@studyease.tech',
                to: newUser.email,
                subject: 'Welcome to Study Ease 😀',
                // text: `Here is your One Time Password : ${newUser.OTP}`,
                html: `
                <p>Hi,</p>

                <p>I'm Sushant, the developer of Study Ease. Thank you for creating an account in my app. I hope that my app will be beneficial to your studies.</p>
                
                <p>Here is your One-Time-Password:&#160; <b>${newUser.OTP}</b></p>
                
                <p>For any doubts or support, please email us at support@studyease.com.</p>
                
                <p>Join on WhatsApp: - <a href="https://chat.whatsapp.com/JA6TAD3foPnFKNIelGlS7z">https://chat.whatsapp.com/JA6TAD3foPnFKNIelGlS7z</a></p>
                
                <p>Thank You</p>`
            })
        }
    
        sendMail().catch(err => {
            return next(err)
        })

        return res.status(200).json({
            status: 'success',
            message: 'Your account has been created successfully.',
            token: token,
        })
    } catch (err) {
        return next(err)
    }
}

exports.OTPVerify = async (req, res, next) => {
    try {
        const OTP = req.body.OTP
        const user = await getUserFromToken(req, res, next)
        req.user = user

        if(!OTP){
            return next(new CustomError('Please enter the OTP.', 401))
        }
        const isOTPValid = await req.user.verifyOTP(OTP, req.user.OTP)

        if(isOTPValid) {
            await req.user.updateOne({accountStatus: 'pendingCompletion'})
            await req.user.updateOne({OTP : undefined})
            return res.status(200).json({
                status: 'success',
                message: 'Your account has been activated.'
            })
        } else {
            return res.status(401).json({
                status: 'fail',
                message: 'Invalid OTP'
            })
        }
        
    } catch (err) {
        return next(err)
    }
}

exports.completeProfile = async (req, res, next) => {
    const { name, phoneNumber, college } = req.body

    if(!phoneNumber || !college) {
        return next(new CustomError('Please provide required information.', 404))
    }

    const user = await getUserFromToken(req, res, next)
    req.user = user

    try {
        await req.user.updateOne({ name: name, phoneNumber: phoneNumber, college: college, accountStatus: 'active'})
    } catch(err) {
        return next(err)
    }

    return res.status(200).json({
        status: 'success',
        message: 'Profile completed successfully.'
    })
}

exports.login = async (req, res, next) => {
    const { email, password } = req.body

    if(!email || !password) {
        return next(new CustomError('Please provide a valid email and password.'), 400)
    }
    let user

    try {
        user = await User.findOne({ email }).select('+password')
        
        if(!user || !await user.checkPassword(password)) {
            return next(new CustomError('Entered email or password is incorrect.', 401))
        }
    } catch (err) {
        return next(err)
    }

    const token = jwt.sign({ id : user._id}, process.env.JWT_SECRET)

    req.user = user

    return res.status(200).json({
        status:'success',
        token: token,
        message: 'You have successfully signed in.',
        account: user
    })
}

exports.autoLogin = async (req, res, next) => {
    try {
        const user = await getUserFromToken(req, res, next)
        req.user = user

        return res.status(200).json({
            status: 'success',
            token: await req.headers.authorization.split(' ')[1],
            message: 'You have successfully signed in.',
            account: user
        })
    } catch (err) {
        return next(err)
    }
}

exports.forgotPassword = async (req, res, next) => {
    try {
        const { email } = req.body

        if(!email) {
            return next(new CustomError('Email not specified.', 401))
        }

        const user = await User.findOne({ email })

        if(!user){
            return next(new CustomError('No user found with given email.', 404))
        }

        if(user['accountStatus'] == 'disabled'){
            return next(new CustomError('Account disabled.', 400))
        }  

        try{
            await user.createPasswordResetOTP()
            user.save({validateBeforeSave : false})

            req.email = user.email

                    async function sendMail(){
                        const transporter = nodemailer.createTransport({
                            host: 'smtp.mailgun.org',
                            port : 587,
                            secure: false,
                            auth : {
                                user : process.env.MAILGUN_USER,
                                pass : process.env.MAILGUN_PASSWORD
                            }
                        })
    
                        let info = await transporter.sendMail({
                            from: 'sushant@studyease.tech',
                            to: user.email,
                            subject: 'Reset your Study Ease Passsword.',
                            html: `
                            <p>Hi,</p>
                            
                            <p>Here is your One-Time-Password:&#160; <b>${user.OTP}</b></p>
                            
                            <p>For any doubts or support, please email us at support@studyease.tech.</p>
                            
                            <p>Join on WhatsApp: - <a href="https://chat.whatsapp.com/JA6TAD3foPnFKNIelGlS7z">https://chat.whatsapp.com/JA6TAD3foPnFKNIelGlS7z</a></p>
                            
                            <p>Thank You</p>`  
                        })
                    }
    
                    sendMail().catch(err => {return next(err)})

            return res.status(200).json({
                status: 'success',
                message: 'An OTP has been created and sent to your email address.'
            })

        } catch(err){
            return next(err)
        }   

    } catch (err) {
        return next(err)
    }
}


exports.resetPassword = async (req, res, next) => {
    try {
        const OTP = req.body.OTP
        const newPassword = req.body.newPassword
        if(!OTP){
            return next(new CustomError('OTP not found.', 404))
        }

        const user = await User.findOne({ OTP })   

        if(!user){
            return next(new CustomError('Entered OTP is not valid.', 400))
        }

        try {
            user.password = newPassword

            await user.save().then(async () => {
                await user.resetOTP()
                user.save({ validateBeforeSave: true })
            })

            return res.status(200).json({
                status: 'success',
                message: 'Your password has been updated.'
            })

        } catch (err) {
            return next(err)
        }
        
    } catch (err) {
        return next(err)
    }
}

exports.protectAuth = async (req, res, next) => {
    try {
        let decoded
        let token

        if(req.headers.authorization && req.headers.authorization.startsWith('Bearer')){
            token = await req.headers.authorization.split(' ')[1]
        }
        if(token === undefined){
            return next(new CustomError('You are not logged in.', 401))
        }
        try {
            decoded = jwt.verify(token, process.env.JWT_SECRET)
        } catch (err) {
            return next(err)
        }

        const freshUser = await User.findOne({id: decoded._id})
        if(!freshUser) return next(new CustomError('User has been deleted.', 401))

        req.user = freshUser
        next()
    } catch (err) {
        return next(err)
    }
}


exports.protectAdmin = async (req, res, next) => {
    try {
        let token
        if(req.headers.authorization && req.headers.authorization.startsWith('Bearer')){
            token = await req.headers.authorization.split(' ')[1]
        }
        if(token === undefined){
            return next(new CustomError('You are not logged in.', 401))
        }

        const decodedToken = jwt.verify(token, process.env.JWT_SECRET)
        const user = await User.findById(decodedToken.id)
        
        if(user.isAdmin != true) return next(new Error('Action not allowed.', 405))

        next()
    } catch (err) {
        return next(err)
    }
}