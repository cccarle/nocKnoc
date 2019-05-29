require('dotenv').config()
const crypto = require('crypto')
const qs = require('qs')


const slack = (req, res, next) => {
  if (req.body) {
    let requestBody = qs.stringify(req.body, { format: 'RFC1738' })
    let timeStamp = req.headers['x-slack-request-timestamp']
    let slackSignature = req.headers['x-slack-signature']

    // protect against replay attack
    if ((Math.floor(new Date() / 1000) - timeStamp) > 60 * 5) {
      // if it's more than 5 min difference, it could be a replay attack.
      console.log('could be a replay attack')
      res.status(401).json()
    }

    // concatinate the version number with timestamp and the req.body
    let version = 'v0'
    let signatureBaseString = `${version}:${timeStamp}:${requestBody}`
    hash = crypto.createHmac('sha256', process.env.slack_signing_secret).update(signatureBaseString).digest('hex')
    my_string = `${version}=${hash}`

    if (my_string === slackSignature) {
      console.log('valid post from slack')
      next()
    } else {
      res.status(403).json()
    }

  } else {
    res.status(403).json()
  }
}
const client = (req, res, next) => {
  let clientHeader = req.headers['client-signature']
  let signature = process.env.client_signature
  let hash = crypto.createHmac('sha256', signature).update('foobar').digest('hex')
  if(hash === clientHeader) {
    console.log('DA MATCH:', hash, clientHeader) // TODO: Remove
    next()
  } else {
    console.log('DA FAIL: ', hash, clientHeader) // TODO: Remove
    res.status(403).send('No way, José!')
  }

}

module.exports = {
  slack,
  client
}
