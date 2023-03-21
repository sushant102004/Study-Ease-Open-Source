const {Notes} = require('./../models/notesModel')
const {User} = require('./../models/userModel')
const {Event} = require('./../models/eventModel')
const CustomError = require('./../utils/CustomError')
const dotenv = require('dotenv').config()
const aws = require('aws-sdk')
const multerS3 = require('multer-s3')
const multer = require('multer')
const path = require('path')


// ---------------------------------------------------------------- User Management

exports.getUsers = async (req, res, next) => {
    try {
        let queryString = req.query

        const users = await User.find(queryString)
        return res.status(200).json({
            status: 'success',
            users: users,
            total: users.length
        })
    } catch (err) {
        return next(err)
    }
}

exports.modifyUser = async (req, res, next) => {
    try {
        const user = await User.findById(req.params.id)
        if(!user) {
            return res.status(404).json({
                status : 'fail',
                message : 'User not found.'
            })
        }

        user.name = req.body.name || user.name
        user.email = req.body.email || user.email
        user.accountStatus = req.body.accountStatus || user.accountStatus
        user.college = req.body.email || user.college
        user.phoneNumber = req.body.email || user.phoneNumber

        await user.save({validateBeforeSave: false})

        return res.status(200).json({
            status : 'success',
            message : 'User has been modified successfully.'
        })

    } catch (err) {
        return next(err)
    } 
}


// ---------------------------------------------------------------- Notes Management
exports.getAllNotes = async (req, res, next) => {
    try {
        const notes = await Notes.find().populate('uploadedBy')
    
        if(notes.length == 0) {
            return res.status(200).json({
                status: 'success',
                message: 'No notes found.'
            })
        }

        return res.status(200).json({
            status: 'success',
            notes: notes,
            total: notes.length
        })
    } catch (err) {
        return next(err)
    }
}

exports.modifyNotes = async (req, res, next) => {
    try {
        const notes = await Notes.findById(req.params.id)
        if(!notes) {
            return res.status(404).json({
                status: 'Not Found',
                message: 'Notes not found.'
            })
        }

        notes.title = req.body.title || notes.title
        notes.shortDescription = req.body.shortDescription || notes.shortDescription
        notes.description = req.body.description || notes.description
        notes.subject = req.body.subject || notes.subject

        // Send this as string.
        notes.isVerified = req.body.isVerified || notes.isVerified
        notes.downloadLink = req.body.downloadLink || notes.downloadLink
        notes.views = req.body.views || notes.views

        await notes.save({validateBeforeSave: false})
        
        return res.status(200).json({
            status: 'success',
            message: 'Notes updated successfully.'
        })

    } catch (err) {
        return next(err)
    }
}


// ---------------------------------------------------------------- Events Management
exports.getAllEvents = async (req, res, next) => {
    try {
        const events = await Event.find()

        return res.status(200).json({
            status: 'success',
            events: events,
            total: events.length
        })
    } catch (err) {
        return next(err)
    }
}



const spacesEndpoint = new aws.Endpoint('https://sgp1.digitaloceanspaces.com')

const s3 = new aws.S3({
    endpoint: spacesEndpoint,
    accessKeyId: process.env.SpacesAccessKey,
    secretAccessKey: process.env.SpacesSecretAccessKey
})

let fileName


const upload = multer({
    storage: multerS3({
        s3: s3,
        bucket: 'studyease/event-posters',
        acl: 'public-read',
        key: function (req, file, callback) {
            fileName = `${Date.now()}${path.extname(file.originalname)}`
            callback(null, fileName)   
        }
    })
}).single('event-poster')



exports.addEvent = async (req, res, next) => {
    upload(req, res, async function(err) {
        const { title, date, time, additionalInformation, hostedBy, link } = req.body

        if(!title || !date || !time || !additionalInformation || !hostedBy || !link){
            return next(new CustomError('Provide valid event details.', 404))
        }

        try {
            await Event.create({
                title : title,
                image : `https://studyease.sgp1.digitaloceanspaces.com/event-posters/${fileName}`,
                date : date,
                time : time,
                additionalInformation : additionalInformation,
                hostedBy : hostedBy,
                link : link
            })
        } catch (err) {
            return next(err)
        }

        return res.status(200).json({
            status: 'success',
            message: 'Event added successfully.'
        })
    })
}


exports.modifyEvent = async (req, res, next) => {
    try {
        const event = await Event.findById(req.params.id)
        if(!event) {
            return res.status(404).json({
                status: 'Not Found',
                message: 'Event not found.'
            })
        }

        event.title = req.body.title || event.title
        event.image = req.body.image || event.image
        event.date = req.body.date || event.date
        event.time = req.body.time || event.time
        event.additionalInformation = req.body.additionalInformation || event.additionalInformation
        event.hostedBy = req.body.hostedBy || event.hostedBy
        event.link = req.body.link || event.link

        await event.save({validateBeforeSave: false})

        return res.status(200).json({
            status: 'success',
            message: 'Event updated successfully.'
        })

    } catch (err) {
        return next(err)
    }
}