const api = require('./slack/api')
const saveTimeInMinutes = 10
let aTimestamp = 1557754195439
let userCache = {
  timestamp: 0,
  data: []
}

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
  if (cachedTime) {
    return cachedTime + saveTime < Date.now()
  }
  return true
}

module.exports = {getAllUsers}
