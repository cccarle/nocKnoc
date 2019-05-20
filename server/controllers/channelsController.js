const api = require('../utils/slack/api')
const settingsFile = require('../utils/readSettingsFile')

let timer
module.exports = {

  getAll: async () => {
    let result = await api.getAllChannels()
    let channels = result.channels.map(
      ({ id, name }) => ({
        id,
        name
      })
    )
    return channels
  },
  sendAcceptDecline: async (visitor, name, channelId) => {
    clearTimeout(timer)
    let settings = await settingsFile.readFile()
    let timeToFallback = settings.settings.secondsToFallback * 1000
    let response = await sendAcceptFormToChannel(visitor, name, channelId)
    timer = setTimeout(() => {
      sendAcceptFormToFallbackChannel(visitor, name)
    }, 5000)
    return response
  }
}


const sendAcceptFormToChannel = async (visitor, name, channelId) => {
  let text = `${visitor} är vid dörren, söker ${name}`
  let result = await api.sendFormToChannel(channelId, text)
  return result
}
const sendAcceptFormToFallbackChannel = async (visitor, name) => {
  let settings = await settingsFile.readFile()
  let channelId = settings.settings.fallbackChannel
  let text = `${visitor} är vid dörren, söker ${name}`
  let result = await api.sendFormToChannel(channelId, text)
  return result
}
