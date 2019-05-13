const server = require('express').Router()
const employeesController = require('../controllers/employeesController')
const channelsController = require('../controllers/channelsController')
const teamsController = require('../controllers/teamsController')
const deviceInfoController = require('../controllers/deviceInfoController')
const slack = require('../utils/slack/api')
const errorHandling = require('../utils/errorHandling')
const testUsers = require('../resources/testUsers')
const answerController = require('../controllers/answerController.js')
const validate = require('../middleware/validateSecret')
const teamSettingsController = require('../controllers/teamSettingsController')
require('dotenv').config()

server.get('/employees', async (req, res) => {
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
    console.log(result)
    res.status(200).json(result)
  } catch (e) {
    let handledError = errorHandling(e)
    res.status(handledError.code).json(handledError.message)
  }
})

server.get('/channels', async (req, res) => {
  try {
    let result = await channelsController.getAll()
    console.log(result)
    res.status(200).json(result)
  } catch (e) {
    let handledError = errorHandling(e)
    res.status(handledError.code).json(handledError.message)
  }
})

server.get('/employeestest', (req, res) => {
let users = testUsers
res.status(200).json(users)
})

server.get('/teams', async (req, res) => {
  try {
    let teams = await teamsController.getWhiteListedTeams()
    console.log(teams)
    res.status(200).json(teams)
  } catch (e) {
    let handledError = errorHandling(e)
    console.log(e)
    res.status(handledError.code).json(handledError.message)
  }
})

server.post('/notify', async (req, res) => {
  try {
    if (req.body.channelId && req.body.visitor && req.body.name) {
      let result = await channelsController.sendAcceptDecline(req.body.visitor, req.body.name, req.body.channelId)
      console.log(result)
      res.status(200).json(result)
    } else if (req.body.employeeId) {
      console.log(`---------------`)
      let result = await employeesController.sendAcceptDecline(req.body.employeeId)
      res.status(200).json(result)
    } else {
      res.status(400)
    }
  } catch (e) {
    console.log('something whent wrong')
    res.status(500).send(e)
  }
})

server.post('/deviceinfo', async (req, res) => {
  try {
    let result = await deviceInfoController.sendDeviceMessage(req.body.message)
    res.status(200).json({result: result})
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

server.post('/payload', validate, async (req, res, next) => {
  try {
  let parsed = JSON.parse(req.body.payload)
  if (parsed.actions[0].value === 'true') {
    console.log(req.headers)
    let result = await answerController.answerHandler(parsed)
    req.io.sockets.emit('answer', 'sho')
    res.status(200)
} else {
  console.log(req.body)
  res.status(200)
}
  } catch (e) {
    let handledError = errorHandling(e)
    res.status(handledError.code).json(handledError.message)
  }

})

server.post('/teamshandler', async (req, res, next) => {
  try {
    let parsed = JSON.parse(req.body)
    console.log(req.body)
    let result = await teamSettingsController.sendSelectionBlock(parsed)
    res.status(200).json({text: "testing slash command"})
  } catch (e) {

    console.log(e)
    
  }
})

module.exports = server
