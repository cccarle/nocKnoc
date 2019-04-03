var Slack = require("slack")
require("dotenv").config()

const token = process.env.Bot_User_OAuth_Access_Token

let bot = new Slack({token})

module.exports = {
  testSlack: async () => {
    return result = await bot.api.test({hyper:'card', hej: 'bye'})
},
  getAllUsers: async () => {
    return await bot.users.list()
  },
  getAllChannels: async () => {
    return await bot.channels.list()
  },
  sendMessageToChannel: async () => {
    return await bot.chat.postMessage()
  }

}
