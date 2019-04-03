const server = require("express").Router()
const employeesController = require('../controllers/employeesController')
const channelsController = require('../controllers/channelsController')

  server.get("/employees", async (req, res) => {
    let result = await employeesController.getAll()
    console.log(result)
    res.json(result)
  })

  server.get("/channels", async (req, res) => {
    let result = await channelsController.getAll()
    console.log(result)
    res.json(result)
  })

module.exports = server
