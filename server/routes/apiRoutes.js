const server = require('express').Router()
const employeesController = require('../controllers/employeesController')
const channelsController = require('../controllers/channelsController')
const teamsController = require('../controllers/teamsController')
const deviceInfoController = require('../controllers/deviceInfoController')
const slack = require('../utils/slack/api')
const errorHandling = require('../utils/errorHandling')
// const usersObject = require('../resources/usersObject')
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
// server.get('/employeestest', (req, res) => {
// let users = usersObject
// res.status(200).json(users)
// })

server.get('/teams', async (req, res) => {
  try {
    let teams = await teamsController.getWhiteListedTeams()
    console.log(teams)
    res.status(200).json(teams)
  } catch (e) {
    let handledError = errorHandling(e)
    res.status(handledError.code).json(handledError.message)
  }
})

server.post('/notify', async (req, res) => {
  try {
    if (req.body.channelId) {
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

server.post('/payload', (req, res, next) => {
  try {
  // let payload = JSON.parse(req.body.payload)
    console.log(req.body)
  // console.log(payload.actions[0].value)
    res.status(200)
  } catch (e) {
    let handledError = errorHandling(e)
    res.status(handledError.code).json(handledError.message)
  }
})

module.exports = server
