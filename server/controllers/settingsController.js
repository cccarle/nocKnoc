const api = require("../utils/slack/api")
const selectBlock = require("../resources/selectBlock")
const teamsController = require("./teamsController")
const settingsObject = require("../utils/readSettingsFile")
const settingsBlock = require('../resources/settingsBlock')
const workspace = require('../utils/workspace')

// Generar Slack-Block med alla inställningar. 
const createSettingsBlocks = async () => {
  let allTeams = await workspace.getTeams()
  let whitelistedTeams = await teamsController.extractWhitelistedTeams(allTeams)
  let blacklistedTeams = await teamsController.extractBlacklistedTeams(allTeams)
  let unHiddenTeams = await whiteListedTeamsToBlock(whitelistedTeams)
  let hiddenTeams = await blackListedTeamsToBlock(blacklistedTeams)
  let answer = [...unHiddenTeams, ...hiddenTeams]

  return answer
}

// Skickar settings till kanalen 
const sendSelectionBlock = async payload => {
  let answer = await createSettingsBlocks()
  console.log(answer)
  let result = await api.sendTeamsToChannel(payload.channel_id, answer)
  console.log(result)

  return result
}

// FALLBACK
const setFallbackById = async (channelId) => {
  let currentSettings = await settingsObject.readFile()
  let old = currentSettings.settings.fallbackChannel
  let response = ''
  if (channelId && typeof channelId === 'string' && channelId.length > 0) {
    try {
      let channel = await api.getChannelById(channelId)

      currentSettings.settings.fallbackChannel = channelId
      await settingsObject.writeToFile(currentSettings)
      response += `Bytt från ${old} \n`

    } catch {
      response += 'Något gick fel. Angiven kanal är privat eller finns inte.\n'
    }

  }
    response += 'Nuvarande ' + currentSettings.settings.fallbackChannel
    return response
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
      selectBlock.selectBlock(team.handle, team.id, "Göm team")
    )
  })
  return unhiddenTeams
}

const blackListedTeamsToBlock = async blacklistedTeams => {
  let hiddenTeams = []
  blacklistedTeams.forEach(team => {
    hiddenTeams.push(selectBlock.selectBlock(team.handle, team.id, "Visa team"))
  })
  return hiddenTeams
}

// FALLBACK-FUNKTIONALITET
const settingsHandler = async payload => {
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

// FALLBACK
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
  settingsHandler,
  setFallbackById
}
