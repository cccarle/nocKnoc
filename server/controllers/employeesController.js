const api = require('../utils/slack/api')

module.exports = {

  getAllEmployees: async () => {
    let result = await api.getAllUsers()
    let employees = result.members.map((id, team_id, real_name, profile) => (id, team_id, real_name, profile))
    return employees
  },

}