module.exports = (error) => {
  console.log('----------------Inside Errorhandling----------------')
  let code = 500
  let message = 'API server error'
  let slackError = slackErrorHandling(error)
  if (slackError) {
    code = slackError.code
    message = slackError.message
  }
  return {code, message}
}

const slackErrorHandling = (error) => {
  console.log(error)
}
