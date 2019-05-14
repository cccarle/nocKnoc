const api = require('../utils/slack/api')
const settings = require('../resources/settings.json')
const apiWithCache = require('../utils/apiWithCache')

const getAll = async () => {
  let result = await apiWithCache.getAllTeams()
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
  let whiteListedTeamsAndUsers = addUsersToTeams(whiteListedTeams)
  return whiteListedTeamsAndUsers
}

const addUsersToTeams = (teams) => {
  teams.forEach((team) => {
    apiWithCache.getTeamUsersByTeamId(team.id).then(userData => {
      team.users = userData.users || []
    })
  })
  return teams
}

const extractWhitelistedTeams = (teams) => {
  return teams.filter((team) => !settings.teamBlacklist.includes(team.id) && team.channels.length > 0)
}

const extractBlacklistedTeams = (teams) => {
  return teams.filter((team) => settings.teamBlacklist.includes(team.id) && team.channels.length > 0)
}

const extractChannelsFromTeamArray = (teamArray) => {
  return teamArray.map(({channels}) => (channels).join(','))
}

module.exports = {
  getAll,
  getWhiteListedTeams,
  getWhiteListedTeamsAndUsers,
  extractChannelsFromTeamArray,
  extractWhitelistedTeams,
  extractBlacklistedTeams
}
