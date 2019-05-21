const api = require('../utils/slack/api')
const settingsFile = require('../utils/readSettingsFile')
let {acceptDeclineMessage} = require('../resources/blocks.js')

let timer
module.exports = {
  sendAccept: async (visitor, name, channelId) => {
    clearTimeout(timer)
    
    let response = await sendAcceptFormToChannel(visitor, name, channelId)
    console.log(response)
    setFallbackTimeout(response.ts, channelId, visitor, name)
    return response
  },
  answerHandler: async (answer) => {
    clearTimeout(timer)
    let channel = answer.container.channel_id
    let ts = answer.container.message_ts
    let name = answer.user.name
    let text = `${name} är på väg att öppna.`
    return api.updateMessage(channel, text, ts)
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

const setFallbackTimeout = async (firstTimestamp, channelId, visitor, name) => {
  let settings = await settingsFile.readFile()
  let fallbackChannelId = settings.settings.fallbackChannel
  let timeToFallback = settings.settings.secondsToFallback * 1000
  timer = setTimeout(async () => {
    sendAcceptFormToFallbackChannel(visitor, name, fallbackChannelId)
    let fallbackChannel = await api.getChannelById(fallbackChannelId)
    let message = `Förfrågan har gått ut till kanal "${fallbackChannel.channel.name}"`
    await api.updateMessage(channelId, message, firstTimestamp)
  }, 5000)
}

const prepareMessage = (visitor, name, ts, channel) => {
  let text = `${visitor} är vid dörren, söker ${name}`
  let block = acceptDeclineMessage(text, ts, channel)
  return {block, text}
}

const sendAcceptFormToChannel = async (visitor, name, channelId) => {
  let {block, text} = prepareMessage(visitor, name)
  let result = await api.sendFormToChannel(channelId, block, text)
  return result
}
const sendAcceptFormToFallbackChannel = async (visitor, name, channelId) => {
  let {block, text} = prepareMessage(visitor, name)
  let fallbackResponse = await api.sendFormToChannel(channelId, block, text)
 
  
  return fallbackResponse
}