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
    let text = `${visitor} är vid dörren, söker ${name}`
    let result = await api.sendFormToChannel(channelId, text)
    return result
  }
}
