
const server = require('express').Router()
const employeesController = require('../controllers/employeesController')
const messageController = require('../controllers/messageController')
const teamsController = require('../controllers/teamsController')
const slack = require('../utils/slack/api')
const errorHandling = require('../utils/errorHandling')
const testUsers = require('../resources/testUsers')
const validate = require('../middleware/validateSecret')
const settingsController = require('../controllers/settingsController')
const workspace = require('../utils/workspace')
require('dotenv').config()

// Returnerar lista med de anställda vars team har kanaler samt inte är i blacklist
server.get("/employees", validate.client, async (req, res) => {
  try {
    let result = await employeesController.getNotifiableEmployees()
    res.status(200).json(result)
  } catch (e) {
    let handledError = errorHandling(e)
    res.status(handledError.code).json(handledError.message)
  }
})

// TODO: REMOVE?
// server.get('/employee/:id', async (req, res) => {
//   try {
//     let id = req.params.id
//     let result = await employeesController.getEmployeeById(id)
//     res.status(200).json(result)
//   } catch (e) {
//     let handledError = errorHandling(e)
//     res.status(handledError.code).json(handledError.message)
//   }
// })

// TODO: REMOVE
// server.get('/channels', async (req, res, next) => {
//   let a = await workspace.getChannels()
//     res.status(200).json(a)
// })


// TODO: REMOVE
// server.get('/employeestest', validate.client, (req, res) => {
//   let users = testUsers
//   res.status(200).json(users)

// })

// Returnerar array med teams som inte ligger i blacklist i settings. Inkluderar teamets kanaler i varje objekt. 
server.get('/teams', validate.client, async (req, res) => {
  try {
    let teams = await teamsController.getWhiteListedTeams()
    res.status(200).json(teams)
  } catch (e) {
    let handledError = errorHandling(e)
    res.status(handledError.code).json(handledError.message)
  }
})

// Skickar ut meddelande till kanal i slack. Tar emot strängarna:
// channelId = Kanalens Id i slack
// visitor = Namn på besökaren. (Besökare, Anställd...)
// userId = Id på användare i slack som ska taggas i inlägget
server.post('/notify', validate.client, async (req, res) => {
  console.log(req.body)
  try {
    if (req.body.channelId && req.body.visitor && req.body.name && req.body.userId) {
      let result = await messageController.sendAccept(
        req.body.visitor,
        req.body.name,
        req.body.userId,
        req.body.channelId
      )
      res.status(200).json(result)
    } else if (!req.body.channelId && req.body.visitor && !req.body.name && !req.body.userId) {
      let result = await messageController.sendToFallback(req.body.visitor)
      res.status(200).json(result)
    } else {
      res.status(400).send('Bad Format')
    }
  } catch (e) {
    console.log(e)
    let handledError = errorHandling(e)
    res.status(handledError.code).json(handledError.message)
  }
})

// Skickar meddelandet i req.body.message till informationskanal i slack. Låg batterinivå etc
server.post('/deviceinfo', validate.client, async (req, res) => {
  try {
    if (req.body.message) {
    let result = await messageController.sendDeviceMessage(req.body.message)
    res.status(200).json(result)
  } else {
    res.status(400).send('Bad Format')
  }
  } catch (e) {
    let handledError = errorHandling(e)
    res.status(handledError.code).json(handledError.message)
  }
})

// Returnerar information om appen i slack
server.get('/botinfo', validate.client, async (req, res) => {
  try {
    let result = await slack.botInfo()
    res.status(200).json(result)
  } catch (e) {
    let handledError = errorHandling(e)
    res.status(handledError.code).json(handledError.message)
  }
})

// Requests från slack. Kontakt/knapptryck från användare
server.post('/payload', validate.slack, async (req, res, next) => {
  try {
    let parsed = JSON.parse(req.body.payload)
    //Ändringar av settings hamnar här
    if (parsed.message.text === "settings") {
      let result = await settingsController.settingsHandler(parsed)
      res.status(200)
    // Accept-svar från anställd när någon söks hamnar här
    } else if (parsed.message.text !== "settings") {
      let result = await messageController.answerHandler(parsed)
      console.log(result, 'APIROUTES')
      req.io.emit('answer', result)
      req.io.emit('answer2', result)
      res.status(200)
    } else {
      res.status(400).send('Bad Format')
    }
  } catch (e) {
    let handledError = errorHandling(e)
    res.status(handledError.code).json(handledError.message)
  }
})
// VALIDERA
server.post('/settings',validate.slack, async (req, res, next) => {
  try {
    console.log(req.body)
    await settingsController.sendSelectionBlock(req.body) // TODO: ska detta returnera något?
    res.status(200).json()

  } catch (e) {
    console.log(e)
    res.status(500).json()
  }
})

server.post('/fallback', validate.slack, async (req, res, next) => {
  console.log(req.body.text)
  let a = await settingsController.setFallbackById(req.body.text)
    res.status(200).send(a)
})

module.exports = server
