const eventsController = require('./../controllers/eventsController')
const authController = require('./../controllers/authController')

const express = require('express')

const router = express.Router()

router.route('/').get(eventsController.getAllEvents)

module.exports = router