const api = require('../utils/slack/api')
const settings = require('../resources/settings.json')

const getAll = async () => {
  let result = await api.getAllTeams()
  let teams = result.usergroups.map(({ id, name, handle, prefs }) => ({
    id,
    name,
    handle,
    channels: prefs.channels
  })
    )
  return teams
}

const getWhiteListedTeams = async () => {
  let teams = await getAll()
  return extractWhitelistedTeams(teams)
}
const getWhiteListedTeamsAndUsers = async () => {
  let whiteListedTeams = await getWhiteListedTeams()
  let whiteListedTeamsAndUsers = await addUsersToTeams(whiteListedTeams)
  return whiteListedTeamsAndUsers
}

const addUsersToTeams = async (teams) => {
  let teamsAndUsers = teams.forEach(async (team) => {
    let users = await api.getTeamUsersByTeamId(team.id)
    if (users) {
      team.users = users.users
    } else {
      team.users = []
    }
  })
  return Promise.all(teamsAndUsers)
}

const extractWhitelistedTeams = (teams) => {
  return teams.filter((team) => !settings.teamBlacklist.includes(team.id) && team.channels.length > 0)
}

const extractChannelsFromTeamArray = (teamArray) => {
  return teamArray.map(({channels}) => (channels).join(','))
}

module.exports = {
  getAll,
  getWhiteListedTeams,
  getWhiteListedTeamsAndUsers,
  extractChannelsFromTeamArray
}
