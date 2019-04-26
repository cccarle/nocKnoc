const server = require('express').Router()
const employeesController = require('../controllers/employeesController')
const channelsController = require('../controllers/channelsController')
const teamsController = require('../controllers/teamsController')

server.get('/employees', async (req, res) => {
  // let result = await employeesController.getAll()
  let teams = await teamsController.getAll()
  console.log(teams)
  res.status(200).json(teams)
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

server.post('/notify-channel', async (req, res) => {
  try {
    if (req.body.channelId) {
      let result = await channelsController.sendAcceptDecline(req.body.channelId)
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

server.post('/payload', (req, res, next) => {
  // let payload = JSON.parse(req.body.payload)
  console.log(req.body)
  // console.log(payload.actions[0].value)
  res.status(200)
})

module.exports = server
