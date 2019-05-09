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
const getWhiteListedTeams = async () => {
  let teams = await getAll()
  let whiteListedTeams = extractWhitelistedTeams(teams)
  return whiteListedTeams.map(({id, name, handle, channels}) => ({id, name, handle, channels}))
}
const getWhiteListedTeamsAndUsers = async () => {
  let teams = await getAll()
  return extractWhitelistedTeams(teams)
}

const getTeamUsersById = async (id) => {
  let result = await api.getTeamUsersByTeamId(id)
  return result.users
}

const extractWhitelistedTeams = (teams) => {
  let whiteListedTeams = teams.filter((team) => !settings.teamBlacklist.includes(team.id) && team.channels.length > 0)
  return whiteListedTeams
}

const extractChannelsFromTeamArray = (teamArray) => {
  return teamArray.map(({channels}) => (channels).join(','))
}

module.exports = {
  getAll,
  getTeamUsersById,
  getWhiteListedTeams,
  getWhiteListedTeamsAndUsers,
  extractChannelsFromTeamArray
}
