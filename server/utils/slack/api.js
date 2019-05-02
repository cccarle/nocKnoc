var Slack = require('slack')
require('dotenv').config()
let {acceptDeclineMessage} = require('../../resources/blocks.js')

// const botToken = process.env.Bot_User_OAuth_Access_Token
// const usoken = process.env.User_OAuth_Access_Token
const botToken = process.env.Bot_Meridium_OAuth_Access_Token
const userToken = process.env.User_Meridium_OAuth_Access_Token

let bot = new Slack({botToken})
let user = new Slack({userToken})
module.exports = {
  testSlack: () => {
    return bot.api.test({hyper: 'card', hej: 'bye'})
  },
  getAllUsers: () => {
    return bot.users.list()
  },
  getAllChannels: () => {
    return bot.channels.list()
  },
  getUserById: (userId) => {
    return bot.users.info({token: botToken, userId})
  },
  getChannelById: (channel) => {
    return bot.channels.info({token: botToken, channel})
  },
  getAllTeams: () => {
    return bot.usergroups.list({token: userToken})
  },
  getTeamUsersByTeamId: (usergroupId) => {
    return bot.usergroups.users.list({token: userToken, usergroupId})
  },
  sendMessageToChannel: (channel, message) => {
    return bot.chat.postMessage({token: botToken, channel: channel, text: message})
  },
  sendFormToChannel: (channel, text) => {
    let blocks = acceptDeclineMessage(text)
    return bot.chat.postMessage({token: botToken, channel, text, blocks})
  },
  botInfo: () => {
    return bot.bots.info({token: botToken})
  }
}
