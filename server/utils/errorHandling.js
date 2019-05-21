module.exports = (error) => {
  let code = 500
  let message = 'API server error'
  let slackError = slackErrorHandling(error)
  console.log(error)
  return {code, message}
}
