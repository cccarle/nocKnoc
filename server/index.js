const express = require('express')
const app = express()
const PORT = process.env.PORT || 5000
const http = require('http')
const bodyParser = require('body-parser')

app.use(bodyParser.json())
app.get('/', (req,res) => {
    res.json({message: "Hello world"})
})

let server = http.createServer(app).listen(PORT, function () {
    console.log('Express started on Port' + PORT)
    console.log('Press Ctrl-C to terminate...')
  })