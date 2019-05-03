require('dotenv').config()
const crypto = require('crypto')
module.exports = (req, res, next) => {
  console.log(req.body, 'from middleware')
  if (req.body) {
    let requestBody = req.body
    let timeStamp = req.headers['X-Slack-Request-Timestamp']
    let slackSignature = req.headers['X-Slack-Signature']
    // protect against replay attack
    if (Date.now() - timeStamp > 60 * 5) {
      // if it's more than 5 min difference, it could be a replay attack.
      console.log('could be a replay attack')
    }
    // concatinate the version number with timestamp and the req.body
    let signatureBaseString = 'v0:' + timeStamp + ':' + requestBody
    let hmac = 'v0:' + crypto.createHmac('sha256', process.env.slack_signing_secret, signatureBaseString)
    let signature = hmac.digest('hex')
    if (hmac.compare(signature, slackSignature)) {
      console.log('valid post from slack')
      next()
    }
  }
}
