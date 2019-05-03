const api = require('../utils/slack/api')

module.exports = {

  getAll: async () => {
    let result = await api.getAllChannels()
    let channels = result.channels.map(
      ({ id, name }) => ({
        id,
        name
      })
    )
    return channels
  },
  sendAcceptDecline: async (visitor, name, channelId) => {
    let text = `${name} is wanted at the door by ${visitor}`
    let result = await api.sendFormToChannel(channelId, text)
    return result
  }
}
