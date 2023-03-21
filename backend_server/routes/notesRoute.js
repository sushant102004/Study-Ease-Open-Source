const express = require('express')
const notesController = require('../controllers/notesController')
const authController = require('../controllers/authController')

const router = express.Router()


router.get('/', authController.protectAuth, notesController.getLatestNotes)
router.post('/upload', authController.protectAuth, notesController.uploadNotes)
router.get('/subject/:subject', authController.protectAuth, notesController.getSubjectWiseNotes)
router.get('/search/:searchText', authController.protectAuth, notesController.searchNotes)
router.post('/incremenet-views', authController.protectAuth, notesController.incrementViews)

module.exports = router