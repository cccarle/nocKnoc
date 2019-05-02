const api = require('../utils/slack/api')
const settings = require('../resources/settings.json')

const getAll = async () => {
  let result = await api.getAllTeams()
  let teams = await result.usergroups.map(
      async ({ id, name, handle, prefs }) => ({
        id,
        name,
        handle,
        channels: prefs.channels,
        users: await getTeamUsersById(id)
      })
    )
  return Promise.all(teams)
}
const getTeamUsersById = async (id) => {
  let result = await api.getTeamUsersByTeamId(id)
  return result.users
}
const getWhiteListedTeams = async () => {
  let teams = await getAll()
  let whiteListedTeams = teams.filter((team) => !settings.teamBlacklist.includes(team.id))
  return whiteListedTeams
}

module.exports = {
  getAll,
  getTeamUsersById,
  getWhiteListedTeams
}
