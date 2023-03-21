class CustomError extends Error {
    constructor(message, errorCode){
        super(message)
        this.statusCode = errorCode
        this.status = `${errorCode}`.startsWith('4') ? 'Not Found' : 'Error'
        
        Error.captureStackTrace(this,this.constructor)
    }
}

module.exports = CustomError