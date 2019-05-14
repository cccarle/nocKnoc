const express = require("express")
const app = express()
const PORT = process.env.PORT || 5000
const http = require("http")
const bodyParser = require("body-parser")
let apiRoutes = require("./routes/apiRoutes")

let server = http.createServer(app).listen(PORT, function() {
  console.log("Express started on Port: " + PORT)
  console.log("Press Ctrl-C to terminate...")
})

const io = require("socket.io")(server)

let socketClient = []
io.on("connection", socket => {
  if (socketClient.length > 0) {
    socketClient.forEach(client => {
      client.disconnect(true)
      console.log('socket has disconnected')
    })
  }
  socketClient = []
  socketClient.push(socket)
  console.log("Websocket is connected", socket.id, 'Connected: ', socketClient.length)

  socket.on("disconnect", () => {
    console.log("Socket has disconnected.", socket.id)
    socket.disconnect()
  })
})
app.use(function(req, res, next) {
  req.io = io
  next()
})

app.use(bodyParser.urlencoded({ extended: true }))
app.use(bodyParser.json())
app.use("/api", apiRoutes)
