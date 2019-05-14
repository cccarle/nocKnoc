const api = require('../utils/slack/api')
const teamsController = require('./teamsController')
const apiWithCache = require('../utils/apiWithCache')

const getAll = async () => {
  let result = await apiWithCache.getAllUsers()
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

const _filterImagesFromProfile = profile => {
  return {
    icon: profile.image_24,
    pic: profile.image_72
  }
}

module.exports = {
  getAll,
  getNotifiableEmployees,
  getEmployeeById
}
