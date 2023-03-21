const { Notes } = require('../models/notesModel')
const CustomError = require('../utils/CustomError')
const path = require('path')
const aws = require('aws-sdk')
const multerS3 = require('multer-s3')
const multer = require('multer')
const dotEnv = require('dotenv')
const ObjectId = require('mongoose').Types.ObjectId

const spacesEndpoint = new aws.Endpoint('https://sgp1.digitaloceanspaces.com')

dotEnv.config()

let fileName

// const storage = multer.diskStorage({
//     destination: (req, file, callback) => {
//         callback(null, path.join(__dirname, '../localNotes'))
//     },
//     filename: (req, file, callback) => {
//         fileName = `${Date.now() + path.extname(file.originalname)}`
//         callback(null, fileName)
//     }
// })

// const upload = multer({storage: storage}).single('notes')


const s3 = new aws.S3({
    endpoint: spacesEndpoint,
    accessKeyId: process.env.SpacesAccessKey,
    secretAccessKey: process.env.SpacesSecretAccessKey
})


const upload = multer({
    storage: multerS3({
        s3: s3,
        bucket: 'studyease/notes',
        acl: 'public-read',
        key: function (req, file, callback) {
            fileName = `${Date.now()}${path.extname(file.originalname)}`
            callback(null, fileName)   
        }
    })
}).single('notes')


function isValidObjectId(id){
    if(ObjectId.isValid(id)){
        if((String)(new ObjectId(id)) === id){
            return true
        }
        return false
    }
    return false
}

exports.getLatestNotes = async (req, res, next) => {
    try {
        const notes = await Notes.find({ isVerified : true }).sort('-uploadedAt').populate('uploadedBy').limit(50)
    
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


exports.uploadNotes = async (req, res, next) => {
    
    upload(req, res, async function (err) {
        const title = req.body.title
        const description = req.body.description
        const shortDescription = description.length <= 45 ? description : description.substring(0, 45) + '...'
        const uploadedBy = req.body.uploadedBy

        if(!title || !description) {
            return next(new CustomError('Invalid details provided.', 404))
        }
        if(err){
            return next(err)
        }

        try {
            const newNotes = await Notes.create({
                title: title,
                shortDescription: shortDescription,
                description: description,
                subject: 'subject',
                uploadedBy: uploadedBy,
                downloadLink: `https://studyease.sgp1.digitaloceanspaces.com/notes/${fileName}`
            })

            res.status(200).json({
                status: 'success',
                message: 'Notes sent for review'
            })
        } catch (err) {
            return next(err)
        }
    })

    // upload(req, res, async function (err) {
        // const title = req.body.title
        // const description = req.body.description
        // const shortDescription = description.length <= 45 ? description : description.substring(0, 45) + '...'
        // const uploadedBy = req.body.uploadedBy

    //     if(!title || !description){
    //         return next(new CustomError('Invalid details provided.', 404))
    //     }
    //     if(err){
    //         return next(err)
    //     }

    //     try {
    //         await Notes.create({
    //             title: title,
    //             shortDescription: shortDescription,
    //             description: description,
    //             subject: 'subject',
    //             uploadedBy: uploadedBy,
    //             downloadLink: `https://studyease.sgp1.digitaloceanspaces.com/notes/${fileName}`
    //         })

    //         res.status(200).json({
    //             status: 'success',
    //             message: 'Notes sent for review'
    //         })
    //     } catch (err) {
    //         return next(err)
    //     }
    // })
    
}



exports.getSubjectWiseNotes = async (req, res, next) => {
    try {
        const subject = req.params.subject

        if(!subject) {
            return next(new CustomError('Subject not specified.', 404))
        }

        const notes = await Notes.find({ subject : subject, isVerified : true }).populate('uploadedBy')
        
        return res.status(200).json({
            status: 'success',
            notes: notes,
            total: notes.length
        })
    } catch (err) {

    }
}

exports.searchNotes = async (req, res, next) => {
    try {
        const searchText = req.params.searchText
        if(!searchText){
            return next(new CustomError('Search text not provided.', 404))
        }

        if(isValidObjectId(searchText)){
            const notes = await Notes.findById(searchText).populate('uploadedBy')
            
            return res.status(200).json({
                status: 'success',
                notes: Array.of(notes),
                total: 1
            })
        }
        

        const notes = await Notes.find({
            '$or' : [
                { 'title': {$regex : searchText, '$options' : 'i'}, 'description': {$regex : searchText, '$options' : 'i'}, isVerified : true },
            ]
        }).populate('uploadedBy')

        return res.status(200).json({
            status: 'success',
            notes: notes,
            total: notes.length
        })

    } catch (err) {
        return next(err)
    }
}

exports.incrementViews = async (req, res, next) => {
    const notesID = req.body.notesID
    if(!notesID) return next(new CustomError('Notes Id missing.', 404));

    try {
        const notes = await Notes.findById(notesID)
        if(!notes) return next(new CustomError('Couldn\'t find notes with that id.', 404))

        notes['views']++;
        await notes.save();
        return res.status(200).json({
            status: 'success',
            message: 'Views updated successfully.'
        })
    } catch (err) {
        return next(err)
    }
}