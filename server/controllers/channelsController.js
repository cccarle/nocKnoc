const api = require("../utils/slack/apiRoutes")

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
  }
}
