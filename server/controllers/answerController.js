const api = require('../utils/slack/api')

module.exports = {

  answerHandler: async (answer) => {
    // console.log(answer)
    let channel = answer.container.channel_id
    let ts = answer.container.message_ts
    let name = answer.user.name
    return api.updateMessage(channel, name, ts)
  }
}
