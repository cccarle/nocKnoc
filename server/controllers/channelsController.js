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
  sendAcceptDecline: async (channelId) => {
    let channel = await api.getChannelById(channelId)
    let channelName = channel.channel.name
    let text = `${channelName} is wanted at the door`
    let result = await api.sendFormToChannel(channelId, text)
    return result
  }
}
