const express = require('express')
const mongoose = require('mongoose')
const multer = require('multer')
const dotenv = require('dotenv')
const CustomError = require('./utils/CustomError')
const errorController = require('./controllers/errorController')
const userRouter = require('./routes/userRoute')
const notesRouter = require('./routes/notesRoute')
const eventsRouter = require('./routes/eventsRoute')
const adminRouter = require('./routes/adminRoute')

dotenv.config()

const app = express()

// app.use(expressFormidable())
app.use(express.json())


mongoose.set('strictQuery', false)

mongoose.connect(process.env.MONGODB_URI, () => {
    console.log('Connected to MongoDB')

    app.listen(process.env.PORT, () => {
        console.log('Listening on port: ' + process.env.PORT)
    })
})

// Convert _id to id
mongoose.set('toJSON', {
    virtuals: true,
    transform: (doc, converted) => {
        delete converted._id
    }
})

app.use('/api/v1/users', userRouter)
app.use('/api/v1/notes', notesRouter)
app.use('/api/v1/events', eventsRouter)
app.use('/api/v1/admin', adminRouter)

app.get('*', (req, res, next) => {
    next(new CustomError(`The route ${req.originalUrl} is not defined.`, 400))
})

app.use(errorController)