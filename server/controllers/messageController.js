const api = require('../utils/slack/api')
const settingsFile = require('../utils/readSettingsFile')

let timer
module.exports = {
  sendAccept: async (visitor, name, channelId) => {
    clearTimeout(timer)
    let settings = await settingsFile.readFile()
    let timeToFallback = settings.settings.secondsToFallback * 1000
    let response = await sendAcceptFormToChannel(visitor, name, channelId)
    timer = setTimeout(() => {
      sendAcceptFormToFallbackChannel(visitor, name)
    }, 5000)
    return response
  },
  answerHandler: async (answer) => {
    clearTimeout(timer)
    let channel = answer.container.channel_id
    let ts = answer.container.message_ts
    let name = answer.user.name
    return api.updateMessage(channel, name, ts)
  },
  sendDeviceMessage: async message => {
    try {
      let settings = await settingsFile.readFile()
      let channel = settings.settings.deviceInfo.channel
      let tags = '' //Måste vara tom sträng från början
      resource.deviceInfo.tags.forEach(element => {
        tags += element + ' '
      })
      message += '\n'
      let string = message + tags
      let result = await api.sendMessageToChannel(channel, string)
      return result
    } catch (err) {
      return err.message
    }
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

