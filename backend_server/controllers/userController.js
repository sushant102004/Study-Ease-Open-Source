const {User} = require('../models/userModel')
const CustomError = require('../utils/CustomError')

exports.editProfile = async (req, res, next) => {
  const userID = req.body.userID
  const newName = req.body.newName
  const newCollege = req.body.newCollege

  if(!userID) return next(new CustomError('User ID not specified,', 404));
  
  try {
    const user = await User.findById(userID)
    if(!user) return next(new CustomError('No user found.', 404))

    user['name'] = newName
    user['college'] = newCollege

    await user.save()

    return res.status(200).json({
      status: 'success',
      message: 'User updated successfully.'
  })
  } catch (err){
    return next(err)
  } 
}