const api = require("../utils/slack/api")
const selectBlock = require("../resources/selectBlock")
const teamsController = require("../controllers/teamsController")
// const settings = require("../resources/settings")
const allTeamsObject = require("../resources/allTeams")
const fs = require("fs")
const settingsObject = require("../utils/readSettingsFile")
const channels = require('./channelsController')
const settingsBlock = require('../resources/settingsBlock')

const createSettingsBlocks = async () => {
  // let allTeams = await teamsController.getAll()
  let allTeams = allTeamsObject
  let allChannels = await channels.getAll()
  let whitelistedTeams = await teamsController.extractWhitelistedTeams(allTeams)
  let blacklistedTeams = await teamsController.extractBlacklistedTeams(allTeams)
  let unHiddenTeams = await whiteListedTeamsToBlock(whitelistedTeams)
  let hiddenTeams = await blackListedTeamsToBlock(blacklistedTeams)
  let channelsBlock = await channelsToBlock(allChannels)
  let answer = [...unHiddenTeams, ...hiddenTeams, channelsBlock]

  return answer
}

const sendSelectionBlock = async payload => {
  let answer = await createSettingsBlocks()
  let result = await api.sendTeamsToChannel(payload.channel_id, answer)

  return result
}

const channelsToBlock = async (channels) => {
  var block = JSON.parse(JSON.stringify(settingsBlock))
  let {accessory} = block
  let currentSettings = await settingsObject.readFile()
  channels.forEach(channel => {
    let option = {
      text: {
        type: "plain_text",
        text: channel.name,
        emoji: true
      },
      value: channel.id
    }
    if (currentSettings.settings.fallbackChannel === channel.id) {
      accessory.placeholder = option.text
    } else {
      accessory.options.push(option)
    }
  })
  return block
}

const updateSelectionBlock = async payload => {
  let answer = await createSettingsBlocks()
  let result = await api.updateSettingsMessage(
    payload.channel.id,
    payload.message.ts,
    answer
  )
  return result
}

const whiteListedTeamsToBlock = async whitelistedTeams => {
  let unhiddenTeams = []
  whitelistedTeams.forEach(team => {
    unhiddenTeams.push(
      selectBlock.selectBlock(team.handle, team.id, "Hide team")
    )
  })
  return unhiddenTeams
}

const blackListedTeamsToBlock = async blacklistedTeams => {
  let hiddenTeams = []
  blacklistedTeams.forEach(team => {
    hiddenTeams.push(selectBlock.selectBlock(team.handle, team.id, "Show team"))
  })
  return hiddenTeams
}
const teamSettingsHandler = async payload => {
  if (payload.actions[0].type === 'static_select') {
    return handleFallbackChannel(payload)
  } else {
    return handleBlacklistChange(payload)
  }
}

const handleBlacklistChange = async payload => {
  let settings = await settingsObject.readFile()
  var found = settings.teamBlacklist.includes(payload.actions[0].value)
  if (!found) {
    settings.teamBlacklist.push(payload.actions[0].value) //add some data
    await settingsObject.writeToFile(settings)
    let result = updateSelectionBlock(payload)
    return result

  } else if (found) {
    for (let i = 0; i < settings.teamBlacklist.length; i++) {
      settings.teamBlacklist[i] === payload.actions[0].value
        ? settings.teamBlacklist.splice(i, 1)
        : null
    }
    await settingsObject.writeToFile(settings)
    let result = updateSelectionBlock(payload)
    return result
  }
}

const handleFallbackChannel = async payload => {
  let object = await settingsObject.readFile()
  if(object.settings.fallbackChannel !== payload.actions[0].selected_option.value) {
    object.settings.fallbackChannel = payload.actions[0].selected_option.value
    await settingsObject.writeToFile(object)
    let result = updateSelectionBlock(payload)
    return result
  }
}

module.exports = {
  sendSelectionBlock,
  whiteListedTeamsToBlock,
  blackListedTeamsToBlock,
  teamSettingsHandler
}
