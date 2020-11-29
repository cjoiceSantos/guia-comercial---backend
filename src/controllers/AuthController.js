
const connection = require('../database/connection');
const jwt = require('jsonwebtoken');
const bcrypt = require('bcrypt')

module.exports = {
  async login(request, response) {
    const { body: { email, password } } = request

    try {
      const user = await connection('user').where('email', email)
        .select('*')
        .first()

      if (!user) {
        return response.status(401)
          .json({
            error: "User not found"
          })
      }

      if (!bcrypt.compareSync(password, user.password)) {
        return response.status(401)
          .json({
            error: "User unauthenticated!"
          })
      }
      const expiresIn = 604800
      const token = jwt.sign({ id: user.id, email: user.email }, process.env.JWT_SECRET, { expiresIn })

      return response.status(200)
        .json({
          user,
          accessToken: token,
          expires_in: expiresIn
        })
    } catch (error) {
      return response.status(500)
        .json({ error })
    }
  },

  async me(request, response) {
    try {
      const authUser = request.user
      const user = await connection('user').where('id', authUser.id)
        .select(['id', 'email', 'email_validated', 'created_at', 'updated_at'])
        .first()

      if (!user) {
        return response.status(401)
          .json({ error: "User not found!" })
      }

      return response.status(200)
        .json(user)

    } catch (error) {
      return response.status(500)
        .json({
          error
        })
    }

  }
}
