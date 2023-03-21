const mongoose = require('mongoose')

const eventSchema = mongoose.Schema({
    title : {
        type: String,
        required: true,
        trim: true,
    },
    image: {
        type: String,
        required: true,
        trim: true,
    },
    date: {
        type: String,
        required: true,
        trim: true,
    },
    time: {
        type: String,
        required: true,
        trim: true,
    },
    additionalInformation: {
        type: String,
        required: true,
        trim: true,
    },
    hostedBy: {
        type: String,
        required: true,
        trim: true,
    },
    isCompleted: {
        type: Boolean,
        default: false,
    },
    link: {
        type: String,
        required: true,
    }
})


const Event = new mongoose.model('Event', eventSchema)

module.exports = {Event}