var Slack = require('slack')
require('dotenv').config()

// const botToken = process.env.Bot_User_OAuth_Access_Token
// const userToken = process.env.User_OAuth_Access_Token
const botToken = process.env.Bot_Meridium_OAuth_Access_Token
const userToken = process.env.User_Meridium_OAuth_Access_Token

let bot = new Slack({botToken})
let user = new Slack({userToken})
module.exports = {
  testSlack: () => {
    return bot.api.test({hyper: 'card', hej: 'bye'})
  },
  getAllUsers: () => {
    return bot.users.list({token: botToken})
  },
  getAllChannels: () => {
    return bot.channels.list({token: botToken})
  },
  getUserById: (userId) => {
    return bot.users.info({token: botToken, user: userId})
  },
  getChannelById: (channel) => {
    return bot.channels.info({token: botToken, channel})
  },
  getAllTeams: () => {
    return user.usergroups.list({token: userToken})
  },
  getTeamUsersByTeamId: (usergroup) => {
    return user.usergroups.users.list({token: userToken, usergroup})
  },
  sendMessageToChannel: (channel, message) => {
    return bot.chat.postMessage({token: botToken, channel: channel, text: message})
  },
  sendFormToChannel: (channel, blocks, text = '') => {
    return bot.chat.postMessage({token: botToken, channel, text , blocks})
  },
  botInfo: () => {
    return bot.bots.info({token: botToken})
  },

  sendTeamsToChannel: (channel, blocks) => {
    return bot.chat.postMessage({token: botToken, channel: channel, text: 'settings', blocks: JSON.stringify(blocks)})
  },

  updateMessage: (channel, text, ts, blocks = []) => {
    return bot.chat.update({token: botToken, channel, text, ts, as_user: true, blocks})
  },
  deleteMessage: (channel, ts) => {
    return bot.chat.delete({token: botToken, channel, ts})
  },
  updateSettingsMessage: (channel, ts, blocks) => {
    return bot.chat.update({token: botToken, channel: channel, text: "settings", ts, as_user: true, blocks})
  }
}
