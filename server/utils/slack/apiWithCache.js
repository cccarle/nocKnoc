const api = require('./api')
const saveTimeInMinutes = 30

let userCache = {
  timestamp: 0,
  data: []
}
let teamsCache = {
  timestamp: 0,
  data: []
}

let teamUsersCache = {
}

// USERS
const getAllUsers = () => {
  if (isTimeUp(userCache.timestamp) || userCache.data.length <= 0) {
    console.log('Fetching new Data for users')
    userCache.timestamp = Date.now()
    userCache.data = getUsersFromApi()
  } else {
    console.log('Using Cache for users')
  }
  return userCache.data
}

const getUsersFromApi = () => {
  try {
    return api.getAllUsers()
  } catch (e) {
    if (userCache.data.length > 0) {
      return userCache.data
    } else {
      throw Error('Cant reach Slack')
    }
  }
}

// TEAMS
const getAllTeams = () => {
  if (isTimeUp(teamsCache.timestamp) || teamsCache.data.length <= 0) {
    console.log('Fetching new data for teams')
    teamsCache.timestamp = Date.now()
    teamsCache.data = getTeamsFromApi()
  } else {
    console.log('Using Cache for teams')
  }
  return teamsCache.data
}

const getTeamsFromApi = () => {
  try {
    return api.getAllTeams()
  } catch (e) {
    if (teamsCache.data.length > 0) {
      return teamsCache.data
    } else {
      throw Error('Cant reach Slack')
    }
  }
}

// TEAM USERS

const getTeamUsersByTeamId = (usergroup) => {
  if (!teamUsersCache[usergroup] || isTimeUp(teamUsersCache[usergroup].timestamp)) {
    console.log('Updating users in team ' + usergroup)
    teamUsersCache[usergroup] = {}
    teamUsersCache[usergroup].timestamp = Date.now()
    teamUsersCache[usergroup].data = getTeamsUsersFromApi(usergroup)
  }
  return teamUsersCache[usergroup].data
}

const getTeamsUsersFromApi = (usergroup) => {
  return api.getTeamUsersByTeamId(usergroup)
}

const isTimeUp = (cachedTime) => {
  let saveTime = saveTimeInMinutes * 60000
  return cachedTime + saveTime < Date.now()
}

module.exports = {
  getAllUsers,
  getAllTeams,
  getTeamUsersByTeamId
}
