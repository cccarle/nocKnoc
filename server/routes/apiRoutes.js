const server = require('express').Router()
const employeesController = require('../controllers/employeesController')
const messageController = require('../controllers/messageController')
const teamsController = require('../controllers/teamsController')
const slack = require('../utils/slack/api')
const errorHandling = require('../utils/errorHandling')
const testUsers = require('../resources/testUsers')
const validate = require('../middleware/validateSecret')
const settingsController = require('../controllers/settingsController')
require('dotenv').config()

server.get("/employees", async (req, res) => {
  try {
    let result = await employeesController.getNotifiableEmployees()
    res.status(200).json(result)
  } catch (e) {
    let handledError = errorHandling(e)
    res.status(handledError.code).json(handledError.message)
  }
})

server.get('/employee/:id', async (req, res) => {
  try {
    let id = req.params.id
    let result = await employeesController.getEmployeeById(id)
    res.status(200).json(result)
  } catch (e) {
    let handledError = errorHandling(e)
    res.status(handledError.code).json(handledError.message)
  }
})

server.get('/employeestest', validate.client, (req, res) => {
  let users = testUsers
  res.status(200).json(users)
})

server.get('/teams', async (req, res) => {
  try {
    let teams = await teamsController.getWhiteListedTeams()
    res.status(200).json(teams)
  } catch (e) {
    let handledError = errorHandling(e)
    res.status(handledError.code).json(handledError.message)
  }
})

server.post('/notify', async (req, res) => {
  try {
    if (req.body.channelId && req.body.visitor && req.body.name) {
      let result = await messageController.sendAccept(
        req.body.visitor,
        req.body.name,
        req.body.channelId
      )
      res.status(200).json(result)
    } else {
      res.status(400).send('Bad Format')
    }
  } catch (e) {
    let handledError = errorHandling(e)
    res.status(handledError.code).json(handledError.message)
  }
})

server.post('/notifyall', async (req, res) => {
  
 })

server.post('/deviceinfo', async (req, res) => {
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

server.get('/botinfo', async (req, res) => {
  try {
    let result = await slack.botInfo()
    res.status(200).json(result)
  } catch (e) {
    let handledError = errorHandling(e)
    res.status(handledError.code).json(handledError.message)
  }
})

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
      console.log('User som acceptat:', parsed.user.id)
      req.io.emit('answer', result)
      console.log('emit ska skickats')
      res.status(200)
    } else {
      res.status(400).send('Bad Format')
    }
  } catch (e) {
    let handledError = errorHandling(e)
    res.status(handledError.code).json(handledError.message)
  }
})

server.post('/teamshandler', async (req, res, next) => {
  try {
    let answer = await settingsController.sendSelectionBlock(req.body)
    console.log(req.body.channel_id, 'I routes')
    res.status(200).json()

  } catch (e) {
    res.status(500)
  }
})

module.exports = server
