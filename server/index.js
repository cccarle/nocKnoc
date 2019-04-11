const express = require('express')
const app = express()
const PORT = process.env.PORT || 5000
const http = require('http')
const bodyParser = require('body-parser')

let apiRoutes = require('./routes/apiRoutes')
app.use(bodyParser.urlencoded({ extended: true }))
app.use(bodyParser.json())
app.use('/api', apiRoutes)

http.createServer(app).listen(PORT, function () {
  console.log('Express started on Port' + PORT)
  console.log('Press Ctrl-C to terminate...')
})
