module.exports = server => {
  server.get("/", (req, res) => {
    res.json({message: "Hello World!"})
  })
}
