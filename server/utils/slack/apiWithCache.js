const api = require('./api')
const saveTimeInMinutes = 30


let userCache = {
  timestamp: 0,
  data: []
}

// USERS

const getAllUsers = () => {
  if (isTimeUp(userCache.timestamp) || userCache.data.length <= 0) {
    userCache.timestamp = Date.now()
    userCache.data = getUsersFromApi()
  }
  return userCache.data
}

const getUsersFromApi = () => {
  console.log('Fetching Data')
  try {
    return api.getAllUsers()
  } catch (e) {
    return userCache.data
  }
}

const isTimeUp = (cachedTime) => {
  let saveTime = saveTimeInMinutes * 60000
  return cachedTime + saveTime < Date.now()
}

module.exports = {
  getAllUsers,
  getAllTeams
}
