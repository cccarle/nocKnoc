const express = require('express')
const app = express()
const PORT = process.env.PORT || 5000
const http = require('http')
const bodyParser = require('body-parser')
const io = require('socket.io')
let apiRoutes = require('./routes/apiRoutes')

// io.on('connection', socket => {
//   console.log('Websocket is connected')
// })

app.use(bodyParser.urlencoded({ extended: true }))
app.use(bodyParser.json())
app.use('/api', apiRoutes)

http.createServer(app).listen(PORT, function () {
  console.log('Express started on Port: ' + PORT)
  console.log('Press Ctrl-C to terminate...')
})
