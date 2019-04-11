var Slack = require('slack')
require('dotenv').config()
let {acceptDeclineMessage} = require('../../resources/blocks.js')

const token = process.env.Bot_User_OAuth_Access_Token

let bot = new Slack({token})
module.exports = {
  testSlack: async () => {
    return result = await bot.api.test({hyper: 'card', hej: 'bye'})
  },
  getAllUsers: async () => {
    return await bot.users.list()
  },
  getAllChannels: async () => {
    return await bot.channels.list()
  },
  getUserById: async (user) => {
    return await bot.users.info({token, user})
  },
  getChannelById: async (channel) => {
    return await bot.channels.info({token, channel})
  },
  getTeamById: async (teamId = 'THJNWMCSG') => {
    // TODO: Make it work
    return await bot.team.info({token})
  },
  sendMessageToChannel: async (channel, text) => {
    return await bot.chat.postMessage({token, channel: 'CHK464ERK', text: 'Hello World!'})
  },
  sendFormToChannel: async (channel, text) => {
    let blocks = acceptDeclineMessage(text)
    return await bot.chat.postMessage({token, channel, text, blocks})
  }
}
