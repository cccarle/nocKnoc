const api = require('../utils/slack/api')
const resource = require('../resources/settings')

module.exports = {
  sendDeviceMessage: async message => {
    try {
      let channel = resource.deviceInfo.channel
      let tags = '' //Måste vara tom sträng från början
      resource.deviceInfo.tags.forEach(element => {
        tags += element + ' '
      })
      message += '\n'
      let string = message + tags
      let result = await api.sendMessageToChannel(channel, string)
      return result
    } catch (err) {
      return err.message
    }
  }
}
