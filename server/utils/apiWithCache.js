const api = require('./slack/api')

let userCache = {}
const getAllUsers = () => {
  if (userCache) {
    console.log(Date.now())
  }
}
module.exports = {getAllUsers}
