module.exports = (req, res, next) => {
  console.log(req.body, 'from middleware')
  if (req.body) {
    next()
  } else {
    res.status(400)
  }
}
