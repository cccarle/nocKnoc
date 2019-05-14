const server = require("express").Router()
const employeesController = require("../controllers/employeesController")
const channelsController = require("../controllers/channelsController")
const teamsController = require("../controllers/teamsController")
const deviceInfoController = require("../controllers/deviceInfoController")
const slack = require("../utils/slack/api")
const errorHandling = require("../utils/errorHandling")
const testUsers = require("../resources/testUsers")
const answerController = require("../controllers/answerController.js")
const validate = require("../middleware/validateSecret")
const teamSettingsController = require("../controllers/teamSettingsController")
require("dotenv").config()


server.get("/employees", async (req, res) => {
  try {
    let result = await employeesController.getNotifiableEmployees()
    res.status(200).json(result)
  } catch (e) {
    let handledError = errorHandling(e)
    res.status(handledError.code).json(handledError.message)
  }
})

server.get("/employee/:id", async (req, res) => {
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

server.get("/channels", async (req, res) => {
  try {
    let result = await channelsController.getAll()
    console.log(result)
    res.status(200).json(result)
  } catch (e) {
    let handledError = errorHandling(e)
    res.status(handledError.code).json(handledError.message)
  }
})

server.get("/employeestest", (req, res) => {
  let users = testUsers
  res.status(200).json(users)
})

server.get("/teams", async (req, res) => {
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

server.post("/notify", async (req, res) => {
  try {
    if (req.body.channelId && req.body.visitor && req.body.name) {
      let result = await channelsController.sendAcceptDecline(
        req.body.visitor,
        req.body.name,
        req.body.channelId
      )
      console.log(result)
      res.status(200).json(result)
    } else {
      res.status(400).send('Missing Data')
    }
  } catch (e) {
    console.log(e)
    let handledError = errorHandling(e)
    res.status(handledError.code).json(handledError.message)
  }
})

server.post("/deviceinfo", async (req, res) => {
  try {
    let result = await deviceInfoController.sendDeviceMessage(req.body.message)
    res.status(200).json({ result: result })
  } catch (e) {
    let handledError = errorHandling(e)
    res.status(handledError.code).json(handledError.message)
  }
})

server.get("/botinfo", async (req, res) => {
  try {
    let result = await slack.botInfo()
    res.status(200).json(result)
  } catch (e) {
    let handledError = errorHandling(e)
    res.status(handledError.code).json(handledError.message)
  }
})

server.post("/payload", validate, async (req, res, next) => {
  try {
    let parsed = JSON.parse(req.body.payload)

    //Ändringar av teamsettings hamnar här
    if (parsed.message.text === "teamsetting") {
      let result = await teamSettingsController.teamSettingsHandler(parsed)
      console.log("TEAM SETTING")
      console.log(block.text.text)
      res.status(200)

    // Accept-svar från anställd när någon söks hamnar här
    } else if (parsed.actions[0].value === "true" && parsed.message.text !== "teamsetting") {
      let result = await answerController.answerHandler(parsed)
      req.io.emit("answer", "sho")
      console.log("emit ska skickats")
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

server.post("/teamshandler", async (req, res, next) => {
  try {
    console.log(req.body)
    let answer = await teamSettingsController.sendSelectionBlock(req.body)
    res.status(200)

  } catch (e) {
    console.log(e)
  }
})

module.exports = server
