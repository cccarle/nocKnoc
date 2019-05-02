const api = require('../utils/slack/api')
const teamsController = require('./teamsController')

module.exports = {
  getAll: async () => {
    let result = await api.getAllUsers()
    // let employees = result.members.map(
    //   ({ id, team_id, real_name, profile }) => ({
    //     id,
    //     team_id,
    //     real_name,
    //     images: _filterImagesFromProfile(profile)
    //   })
    // )
    return result
  },
  getNotifiableEmployees: async () => {
    let teams = await teamsController.getWhiteListedTeams()
    return teams
  },
  getEmployeeById: async (id) => {
    let result = await api.getUserById(id)
    return result
  },
  sendAcceptDecline: async (userId) => {
    let user = await api.getUserById(userId)
    let userName = user.user.real_name
    console.log(user)
    let text = `${userName} is wanted at the door`
    // TODO: FIND CORRECT CHANNEL
    let result = await api.sendFormToChannel(userId, text)
    return text
  }
}
_filterImagesFromProfile = profile => {
  return {
    icon: profile.image_24,
    pic: profile.image_72
  }
}
