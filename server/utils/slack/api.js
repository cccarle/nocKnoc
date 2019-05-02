var Slack = require('slack')
require('dotenv').config()
let {acceptDeclineMessage} = require('../../resources/blocks.js')

// const token = process.env.Bot_User_OAuth_Access_Token
// const token = process.env.User_OAuth_Access_Token
// const token = process.env.Bot_Meridium_OAuth_Access_Token
const token = process.env.User_Meridium_OAuth_Access_Token

let bot = new Slack({token})
module.exports = {
  testSlack: async () => {
    return await bot.api.test({hyper: 'card', hej: 'bye'})
  },
  getAllUsers: async () => {
    return await bot.users.list()
  },
  getAllChannels: async () => {
    return await bot.channels.list()
  },
  getUserById: async (userId) => {
    return await bot.users.info({token, userId})
  },
  getChannelById: async (channel) => {
    return await bot.channels.info({token, channel})
  },
  getAllTeams: async () => {
    return await bot.usergroups.list({token})
  },
  getTeamUsersByTeamId: async (teamId) => {
    return await bot.usergroups.users.list({token, teamId})
  },
  sendMessageToChannel: async (channel, message) => {
    return await bot.chat.postMessage({token, channel: channel, text: message})
  },
  sendFormToChannel: async (channel, text) => {
    let blocks = acceptDeclineMessage(text)
    return await bot.chat.postMessage({token, channel, text, blocks})
  },
  botInfo: async () => {
    return await bot.bots.info({token})
  }
}
