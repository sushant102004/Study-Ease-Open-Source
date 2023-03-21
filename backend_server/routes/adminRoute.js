const express = require('express')
const adminController = require('../controllers/adminController')
const authController = require('../controllers/authController')

const router = express.Router()

router
.route('/users')
.get(authController.protectAdmin, adminController.getUsers)

router.route('/users/modify/:id')
.post(authController.protectAdmin, adminController.modifyUser)

router.route('/notes')
.get(authController.protectAdmin, adminController.getAllNotes)

router.route('/notes/modify/:id')
.post(authController.protectAdmin, adminController.modifyNotes)

router.route('/events')
.get(authController.protectAdmin, adminController.getAllEvents)
.post(authController.protectAdmin, adminController.addEvent)

router.route('/events/modify/:id')
.get(authController.protectAdmin, adminController.modifyEvent)

module.exports = router