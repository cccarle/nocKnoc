const employeesController = require('../controllers/employeesController')

module.exports = server => {
  server.get("/employees", async (req, res) => {
    let result = await employeesController.getAllEmployees()
    console.log(result)
    res.json({message: "Hello World!"})
  })
}
