const express = require('express')
const app = express()
const PORT = process.env.PORT || 5000
const http = require('http')
const bodyParser = require('body-parser')
let apiRoutes = require('./routes/apiRoutes')







let server = http.createServer(app).listen(PORT, function () {
  console.log('Express started on Port: ' + PORT)
  console.log('Press Ctrl-C to terminate...')
})

const io = require('socket.io')(server)

io.on('connection', socket => {
  console.log('Websocket is connected')

  socket.on('disconnect', () => {
    console.log('Socket has disconnected.')
    socket.disconnect()
  })
})

app.use(bodyParser.urlencoded({ extended: true }))
app.use(bodyParser.json())
app.use('/api', apiRoutes)

app.use(function(req, res, next) {
  req.io = io
  next()
})
