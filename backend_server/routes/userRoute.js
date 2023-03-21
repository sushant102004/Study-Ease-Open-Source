const express = require('express')
const authController = require('./../controllers/authController')
const userController = require('./../controllers/userController')
const rateLimit = require('express-rate-limit')

const router = express.Router()

const limiter = rateLimit({
	windowMs: 30 * 60 * 1000,
	max: 3, 
	standardHeaders: true,
	legacyHeaders: false,
})

router.post('/sign-up', limiter, authController.signUp)
router.post('/verify-otp', authController.protectAuth, authController.OTPVerify)
router.post('/login', authController.login)
router.post('/forgot-password', limiter, authController.forgotPassword)
router.post('/reset-password', authController.resetPassword)
router.post('/complete-profile', authController.completeProfile)
router.post('/auto-login', authController.autoLogin)
router.post('/edit-profile', authController.protectAuth, userController.editProfile)

module.exports = router