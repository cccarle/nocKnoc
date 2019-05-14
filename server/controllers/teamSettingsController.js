const api = require('../utils/slack/api')
const selectBlock = require('../resources/selectBlock')
const teamsController = require('../controllers/teamsController')
const settings = require('../resources/settings')
const allTeamsObject = require('../resources/allTeams')
const fs = require('fs')


const createSettingsBlocks = async () => {
// let allTeams = await teamsController.getAll()
let allTeams = allTeamsObject
let whitelistedTeams = await teamsController.extractWhitelistedTeams(allTeams)
let blacklistedTeams = await teamsController.extractBlacklistedTeams(allTeams)
let unHiddenTeams = await whiteListedTeamsToBlock(whitelistedTeams)
let hiddenTeams = await blackListedTeamsToBlock(blacklistedTeams)
let answer = [...unHiddenTeams, ...hiddenTeams]
console.log(answer)
return answer
}

const sendSelectionBlock = async payload => {

  let answer = await createSettingsBlocks()
  let result = await api.sendTeamsToChannel(payload.channel_id, answer)

  return result
}

const updateSelectionBlock = async (payload) => {
 let answer = await createSettingsBlocks()
 let result = await api.updateSettingsMessage(payload.channel_id, payload.message.ts, answer)
 return result
}

const whiteListedTeamsToBlock = async whitelistedTeams => {
  let unhiddenTeams = []
  whitelistedTeams.forEach(team => {
    unhiddenTeams.push(
      selectBlock.selectBlock(team.handle, team.id, 'Hide team')
    )
  })
  return unhiddenTeams
}

const blackListedTeamsToBlock = async blacklistedTeams => {
  let hiddenTeams = []
  blacklistedTeams.forEach(team => {
    hiddenTeams.push(selectBlock.selectBlock(team.handle, team.id, 'Show team'))
  })
  return hiddenTeams
}
const teamSettingsHandler = async payload => {
  var found = settings.teamBlacklist.includes(payload.actions[0].value)

  console.log(payload.actions[0].value, found)

  fs.readFile('resources/settings.json', 'utf8', async function readFileCallback(
    err,
    data
  ) {
    if (err) {
      console.log(err)
    } else if (!found) {
      let obj = JSON.parse(data) //now it an object
      obj.teamBlacklist.push(payload.actions[0].value) //add some data
      json = JSON.stringify(obj) //convert it back to json
      await fs.writeFile('resources/settings.json', json, 'utf8', (err, data) => {
        if(err) {
          console.log(err)
        } else {
          let result = updateSelectionBlock(payload)
          return result
        }
      }) // write it back
      // let result = updateSelectionBlock(payload)
      // return result
    } else if (found) {
      let obj = JSON.parse(data)
      for(let i = 0; i < obj.teamBlacklist.length; i++) {
        console.log(obj.teamBlacklist[i])
        obj.teamBlacklist[i] === payload.actions[0].value ? obj.teamBlacklist.splice(i, 1) : null
      }
      console.log(obj.teamBlacklist)
      json = JSON.stringify(obj)
      await fs.writeFile('resources/settings.json', json, 'utf8', (err, data) => {
        if(err) {
          console.log(err)
        } else {
          let result = updateSelectionBlock(payload)
          return result
        }
      })
    }
  })
}

module.exports = {
  sendSelectionBlock,
  whiteListedTeamsToBlock,
  blackListedTeamsToBlock,
  teamSettingsHandler
}
