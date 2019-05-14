const api = require('../utils/slack/api')
const selectBlock = require('../resources/selectBlock')
const teamsController = require('../controllers/teamsController')
const settings = require('../resources/settings')
const allTeamsObject = require('../resources/allTeams')


  const sendSelectionBlock = async (payload) => {
    // let allTeams = await teamsController.getAll()
    let allTeams = allTeamsObject
    let whitelistedTeams = await teamsController.extractWhitelistedTeams(allTeams)
    let blacklistedTeams = await teamsController.extractBlacklistedTeams(allTeams)
    let unHiddenTeams = await getWhiteListedTeams(whitelistedTeams)
    let hiddenTeams = await getBlackListedTeams(blacklistedTeams)
    let answer = [...unHiddenTeams, ...hiddenTeams]
    let result = await api.sendTeamsToChannel(payload.channel_id, answer)
    return result
  }

  const getWhiteListedTeams = async (whitelistedTeams) => {
    let unhiddenTeams = []
    whitelistedTeams.forEach(team => {
        unhiddenTeams.push(selectBlock.selectBlock(team.handle, "false", 'Hide team'))
      })
      return unhiddenTeams
  }

  const getBlackListedTeams = async (blacklistedTeams) => {
    let hiddenTeams = []
    blacklistedTeams.forEach(team => {
        hiddenTeams.push(selectBlock.selectBlock(team.handle, "true", 'Show team'))
      })
      return hiddenTeams

}
  const teamSettingsHandler = async (payload) => {
    let block = payload.message.blocks.find(x => x.block_id === payload.actions[0].block_id)
    // console.log(block)
    let teamChannelId = allTeamsObject.find(x => x.handle === block.text.text)
    console.log(teamChannelId.channels)

  }

module.exports = {
  sendSelectionBlock,
  getWhiteListedTeams,
  getBlackListedTeams,
  teamSettingsHandler
}
