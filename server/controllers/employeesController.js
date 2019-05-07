const api = require('../utils/slack/api')
const teamsController = require('./teamsController')

const getAll = async () => {
  let result = await api.getAllUsers()
  let employees = result.members.map(
      ({ id, team_id, real_name, profile }) => ({
        id,
        team_id,
        real_name,
        images: _filterImagesFromProfile(profile)
      })
    )
  return employees
}
const getNotifiableEmployees = async () => {
  let employeeArray = []
  let teams = await teamsController.getWhiteListedTeamsAndUsers()
  let employees = await getAll()
  console.log(teams)
  employees.forEach(employee => {
    let employeeTeams = teams.filter(team => team.users.includes(employee.id))
    if (employeeTeams.length > 0) {
      employee.channels = teamsController.extractChannelsFromTeamArray(employeeTeams)
      employeeArray.push(employee)
    }
  })
  return employeeArray
}
const getEmployeeById = async (id) => {
  let result = await api.getUserById(id)
  return result
}
const sendAcceptDecline = async (userId) => {
  let user = await api.getUserById(userId)
  let userName = user.user.real_name
  console.log(user)
  let text = `${userName} is wanted at the door`
    // TODO: FIND CORRECT CHANNEL
  let result = await api.sendFormToChannel(userId, text)
  return text
}

const _filterImagesFromProfile = profile => {
  return {
    icon: profile.image_24,
    pic: profile.image_72
  }
}

module.exports = {
  getAll,
  getNotifiableEmployees,
  getEmployeeById,
  sendAcceptDecline
}
