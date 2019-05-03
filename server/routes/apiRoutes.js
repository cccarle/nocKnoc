const server = require('express').Router()
const employeesController = require('../controllers/employeesController')
const channelsController = require('../controllers/channelsController')
const teamsController = require('../controllers/teamsController')
const deviceInfoController = require('../controllers/deviceInfoController')
const slack = require('../utils/slack/api')

server.get('/employees', async (req, res) => {
  let result = await employeesController.getNotifiableEmployees()
  console.log(result)
  res.status(200).json(result)
})

server.get('/employee/:id', async (req, res) => {
  let id = req.params.id
  let result = await employeesController.getEmployeeById(id)
  console.log(result)
  res.status(200).json(result)
})

server.get('/channels', async (req, res) => {
  let result = await channelsController.getAll()
  console.log(result)
  res.status(200).json(result)
})

server.get('/teams', async (req, res) => {
  let teams = await teamsController.getAll()
  console.log(teams)
  res.status(200).json(teams)
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
  let result = await deviceInfoController.sendDeviceMessage(req.body.message)
  res.status(200).json({result: result})
})

server.get('/botinfo', async (req, res) => {
  let result = await slack.botInfo()
  res.status(200).json(result)
})

server.post('/payload', (req, res, next) => {
  // let payload = JSON.parse(req.body.payload)
  console.log(req.body)
  // console.log(payload.actions[0].value)
  res.status(200)
})

module.exports = server
