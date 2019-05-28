const api = require('../utils/slack/api')
const workspace = require('../utils/workspace')
const settingsFile = require('../utils/readSettingsFile')
let {acceptDeclineMessage} = require('../resources/blocks.js')

let timer
module.exports = {
  sendAccept: async (visitor, name, channelId) => {
    clearTimeout(timer)
    
    let response = await sendAcceptFormToChannel(visitor, name, channelId)
    setFallbackTimeout(response.ts, channelId, visitor, name)
    return response
  },
  answerHandler: async (answer) => {
    clearTimeout(timer)
    let user = await workspace.getEmployeeById(answer.user.id)
    let name = user.real_name
    let pic = user.images.pic
    let channel = answer.container.channel_id
    let ts = answer.container.message_ts
    let text = `${name} är på väg att öppna.`
    setTemporaryMessage(channel, text, ts)
    return {text, pic}
  },
    sendDeviceMessage: async message => {
      let resource = await settingsFile.readFile()
      let channel = resource.deviceInfo.channel
      let tags = '' //Måste vara tom sträng från början
      resource.deviceInfo.tags.forEach(element => {
        tags += element + ' '
      })
      message += '\n'
      let string = message + tags
      let result = await api.sendMessageToChannel(channel, string)
      return result
  },

  sendToFallback: async visitor => {
    let result = await sendAcceptFormToFallbackChannel(visitor)
    return result
  }
}

const setFallbackTimeout = async (firstTimestamp, channelId, visitor, name) => {
  let settings = await settingsFile.readFile()
  let fallbackChannelId = settings.settings.fallbackChannel
  let timeToFallback = settings.settings.secondsToFallback * 1000
  timer = setTimeout(async () => {
    try {
    let fallbackResponse = await sendAcceptFormToFallbackChannel(visitor, name)
    let message = `Förfrågan har gått ut till kanal "${fallbackResponse.channelName}"`
    setTemporaryMessage(channelId, message, firstTimestamp)
  } catch (e) {
    let message = `Ingen fallback kanal vald. Skriv /settings för att få fram inställningsmenyn`
    setTemporaryMessage(channelId, message, firstTimestamp)
    sendAcceptFormToChannel(visitor, name, channelId)
  }
  }, timeToFallback)
}

const setTemporaryMessage = async (channelId, message, timestamp = null) => {
  let result
  if (timestamp) {
    result = await api.updateMessage(channelId, message, timestamp)
  } else {
    result = await api.sendMessageToChannel(channelId, string)    
  }
  setTimeout(() => {
    api.deleteMessage(result.channel, result.ts)
  }, 5000)
  return result
}

const prepareMessage = (visitor, name) => {
  let text
  !name ? text = `${visitor} är vid dörren` : text = `${visitor} är vid dörren, söker ${name}` 
  let block = acceptDeclineMessage(text)
  return {block, text}
}

const sendAcceptFormToChannel = async (visitor, name, channelId) => {
  let {block, text} = prepareMessage(visitor, name)
  let result = await api.sendFormToChannel(channelId, block, text)
  return result
}
const sendAcceptFormToFallbackChannel = async (visitor, name) => {
  let settings = await settingsFile.readFile()
  let channelId = settings.settings.fallbackChannel
  let channel = await api.getChannelById(channelId)
  let {block, text} = prepareMessage(visitor, name)
  let response = await api.sendFormToChannel(channelId, block, text)
  response.channelName = channel.channel.name
 
  
  return response
}