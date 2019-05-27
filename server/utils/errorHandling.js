module.exports = (error) => {
  let code = 500
  let message = 'API server error'
  let slackError = slackErrorHandling(error)
  if (slackError) {
    message = slackError.message
  }
  return {code, message}
}

const slackErrorHandling = (error) => {
  let {name, message} = error
  if (name = 'TypeError') {
    return {code: 500, message}
  }
}