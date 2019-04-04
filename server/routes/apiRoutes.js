const server = require('express').Router()
const employeesController = require('../controllers/employeesController')
const channelsController = require('../controllers/channelsController')
const validatePost = require('../middleware/validatePost')

server.get('/employees', async (req, res) => {
  let result = await employeesController.getAll()
  console.log(result)
  res.status(200).json(result)
})

server.get('/channels', async (req, res) => {
  let result = await channelsController.getAll()
  console.log(result)
  res.status(200).json(result)
})

server.post('/notify-channel', validatePost, async (req, res) => {
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

module.exports = server
