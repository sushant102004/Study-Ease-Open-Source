const CustomError = require('../utils/CustomError')
const {Event} = require('./../models/eventModel')

exports.getAllEvents = async (req, res, next) => {
    try {
        const events = await Event.find()

        res.status(200).json({
            status: 'success',
            events: events,
            total: events.length
        })
    } catch (err) {
        return next(err)
    }
}

exports.searchEvent = async (req, res, next) => {
    const searchQuery = req.body.searchQuery
    try {
        
    } catch (err) {
        const events = await Event.find({
            '$or' : [
                { 'title' : {$regex: searchQuery, '$options' : 'i'}, isCompleted : true}
            ]
        })
    }
}