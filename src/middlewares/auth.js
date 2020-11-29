
const jwt = require('jsonwebtoken')

module.exports = function (req, res, next) {
  const { headers: { authorization } } = req

  const token = !!authorization ? authorization.split(' ')[1] : null

  if (!token) {
    return res.status(401)
      .send({
        msg: 'Token must be provided!',
        auth: false,
      })
  }

  try {
    const decoded = jwt.verify(token, process.env.JWT_SECRET)
    req.user = decoded
    next()
  } catch (error) {
    res.status(401).json({
      error: "Invalid token"
    })
  }
}

