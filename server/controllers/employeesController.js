const api = require('../utils/slack/api')
const teamsController = require('./teamsController')
const apiWithCache = require('../utils/slack/apiWithCache')
const workspace = require('../utils/workspace')

const getNotifiableEmployees = async () => {
  let employeeArray = []
  let teams = await teamsController.getWhiteListedTeamsAndUsers()
  let employees = await workspace.getEmployees()
  employees.forEach(employee => {
    let employeeTeams = teams.filter(team => team.users.includes(employee.id))
    if (employeeTeams.length > 0) {
      employee.channels = teamsController.extractChannelsFromTeamArray(employeeTeams)
      employeeArray.push(employee)
    }
  })
  return employeeArray
}
// const getEmployeeById = async (id) => {
  // let result = await api.getUserById(id)
//   return result
// }

module.exports = {
  getNotifiableEmployees
  // getEmployeeById
}
