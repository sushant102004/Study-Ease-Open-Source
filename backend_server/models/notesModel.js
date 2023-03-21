const mongoose = require('mongoose')

const notesSchema  = mongoose.Schema({
    title: {
        type: String,
        required: [true, 'Notes title is required'],
        trim: true,
        minLength: 2,
        maxLength: 50,
    },
    
    shortDescription: {
        type: String,
        trim: true,
        minLength: 2,
        maxLength: 50,
    },

    description: {
        type: String,
        trim: true,
    },

    subject: {
        type: String,
        trim: true,
        minLength: 2,
        maxLength: 50,
    },

    isVerified: {
        type: Boolean,
        default: false,
    },

    uploadedAt: {
        type: Date,
        default: Date.now()
    },

    uploadedBy: {
        type: mongoose.Schema.ObjectId,
        ref: 'User'
    },

    downloadLink: {
        type: String,
        trim: true
    },

    views: {
        type: Number,
        default: 0,
    }

})


const Notes = new mongoose.model('Notes', notesSchema)

module.exports = { Notes }