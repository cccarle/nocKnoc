const api = require('../utils/slack/api')

module.exports = {
  getAll: async () => {
    let result = await api.getAllTeams()
    // let employees = result.members.map(
    //   ({ id, team_id, real_name, profile }) => ({
    //     id,
    //     team_id,
    //     real_name,
    //     images: _filterImagesFromProfile(profile)
    //   })
    // )
    return result
  }
}
