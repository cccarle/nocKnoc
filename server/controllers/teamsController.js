const apiWithCache = require('../utils/slack/apiWithCache')
const settingsObject = require('../utils/readSettingsFile')
const workspace = require('../utils/workspace')

const getWhiteListedTeams = async () => {
  let teams = await workspace.getTeams()
  return extractWhitelistedTeams(teams)
}
const getWhiteListedTeamsAndUsers = async () => {
  let whiteListedTeams = await getWhiteListedTeams()
  let whiteListedTeamsAndUsers = addUsersToTeams(whiteListedTeams)
  return whiteListedTeamsAndUsers
}

const addUsersToTeams = teams => {
  teams.forEach(team => {
    apiWithCache.getTeamUsersByTeamId(team.id).then(userData => {
      team.users = userData.users || []
    })
  })
  return teams
}

const extractWhitelistedTeams = async teams => {
  let settings = await settingsObject.readFile()
  return teams.filter(
    team =>
      !settings.teamBlacklist.includes(team.id) && team.channels.length > 0
  )
}

const extractBlacklistedTeams = async teams => {
  let settings = await settingsObject.readFile()
  return teams.filter(
    team => settings.teamBlacklist.includes(team.id) && team.channels.length > 0
  )
}

const extractChannelsFromTeamArray = teamArray => {
  // console.log(teamArray)
  let cannels = teamArray.map(({ channels }) => {
    return channels[0]
  })
  return cannels
}

module.exports = {
  getWhiteListedTeams,
  getWhiteListedTeamsAndUsers,
  extractChannelsFromTeamArray,
  extractWhitelistedTeams,
  extractBlacklistedTeams
}
