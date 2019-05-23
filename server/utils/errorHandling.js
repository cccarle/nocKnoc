module.exports = (error) => {
  let code = 500
  let message = 'API server error'
  console.log(error)
  return {code, message}
}
