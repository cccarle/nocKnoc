const api = require('../utils/slack/api')
const workspace = require('../utils/workspace')
const settingsFile = require('../utils/readSettingsFile')
let {acceptDeclineMessage} = require('../resources/blocks.js')

let timer
module.exports = {
  // Skickar notifieringsmeddelande till slack. Startar timer för att skicka till fallback. 
  sendAccept: async (visitor, name, userId, channelId) => {
    clearTimeout(timer)
    let response = await sendAcceptFormToChannel(visitor, name, channelId, userId)
    setFallbackTimeout(response.ts, channelId, visitor, name)
    return response
  },
  // Tar hand om svar från slack när accept-knapp är klickad på
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
  // Skickar meddelande till kanalen i slack som ligger i settings.deviceInfo
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
  // Kallar på funktion som skickar till fallback. Returnerar resultat
  sendToFallback: async visitor => {
    let result = await sendAcceptFormToFallbackChannel(visitor)
    return result
  }
}
// Sätter timeout som stämmer med sekunder i settings.secondsToFallback.
// Raderar meddelandet som stämmer med channelId & firstTimestamp innan den skickar till fallback.
const setFallbackTimeout = async (firstTimestamp, channelId, visitor, name) => {
  let settings = await settingsFile.readFile()
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

// Uppdaterar eller skapar ett meddelande i kanalen beroende på om timestamp finns. Meddelandet försvinner efter fem sekunder
const setTemporaryMessage = async (channelId, message, timestamp = null) => {
  let result
  if (timestamp) {
    result = await api.updateMessage(channelId, message, timestamp)
  } else {
    result = await api.sendMessageToChannel(channelId, message)
  }
  setTimeout(() => {
    api.deleteMessage(result.channel, result.ts)
  }, 5000)
  return result
}

// Skapar dörrmeddelandet för slack.
const prepareMessage = async (visitor, name, userId) => {
  let text = `${visitor} är vid dörren`
  if (userId && name) {
    let user = await api.getUserById(userId)
    let slackName = user.user.name
    text += `, söker ${name} <@${slackName}>`
  } else if (name) {
    text += `, söker ${name}`
  }
  let block = acceptDeclineMessage(text)
  return {block, text}
}
// Skapar ett formulär utav variabeldatan och skickar det till channelId:t
const sendAcceptFormToChannel = async (visitor, name, channelId, userId) => {
  let {block, text} = await prepareMessage(visitor, name, userId)
  let result = await api.sendFormToChannel(channelId, block, text)
  return result
}
// Skapar formulär och skickar till specificerad fallback-kanal i settings.
const sendAcceptFormToFallbackChannel = async (visitor, name) => {
  let settings = await settingsFile.readFile()
  let channelId = settings.settings.fallbackChannel
  let channel = await api.getChannelById(channelId)
  let {block, text} = await prepareMessage(visitor, name)
  let response = await api.sendFormToChannel(channelId, block, text)
  response.channelName = channel.channel.name


  return response
}
