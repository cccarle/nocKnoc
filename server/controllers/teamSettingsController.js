const api = require("../utils/slack/api")
const selectBlock = require("../resources/selectBlock")
const teamsController = require("../controllers/teamsController")
// const settings = require("../resources/settings")
const allTeamsObject = require("../resources/allTeams")
const fs = require("fs")
const settingsObject = require("../utils/readSettingsFile")

const createSettingsBlocks = async () => {
  // let allTeams = await teamsController.getAll()
  let allTeams = allTeamsObject
  let whitelistedTeams = await teamsController.extractWhitelistedTeams(allTeams)
  let blacklistedTeams = await teamsController.extractBlacklistedTeams(allTeams)
  let unHiddenTeams = await whiteListedTeamsToBlock(whitelistedTeams)
  let hiddenTeams = await blackListedTeamsToBlock(blacklistedTeams)
  let answer = [...unHiddenTeams, ...hiddenTeams]
  return answer
}

const sendSelectionBlock = async payload => {
  let answer = await createSettingsBlocks()
  let result = await api.sendTeamsToChannel(payload.channel_id, answer)

  return result
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
  let settings = await settingsObject.readFile()
  let parsed = JSON.parse(settings)
  var found = parsed.teamBlacklist.includes(payload.actions[0].value)
  if (!found) {
    parsed.teamBlacklist.push(payload.actions[0].value) //add some data
    await settingsObject.writeToFile(parsed)
    let result = updateSelectionBlock(payload)
    return result

  } else if (found) {
    for (let i = 0; i < parsed.teamBlacklist.length; i++) {
      parsed.teamBlacklist[i] === payload.actions[0].value
        ? parsed.teamBlacklist.splice(i, 1)
        : null
    }
    await settingsObject.writeToFile(parsed)
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
