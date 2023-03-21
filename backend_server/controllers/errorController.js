module.exports = (err, req, res, next) => {
    err.status = err.status || 'fail'
    err.statusCode = err.statusCode || 500

    if(err.code === 11000){
        return res.status(err.statusCode).json({
            status: err.status,
            message: 'Duplicate Value.',
            error: err,
            stack: err.stack
        })
    }

    res.status(err.statusCode).json({
        status: err.status,
        message: err.message,
        error: err,
        stack: err.stack
    })
}