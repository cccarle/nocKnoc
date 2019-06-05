require('dotenv').config()

test('User token to be string', async () => {
    let token = process.env.User_OAuth_Access_Token
    expect(typeof token).toBe('string')
  })

  test('Bot token to be string', async () => {
    let token =process.env.Bot_User_OAuth_Access_Token
    expect(typeof token).toBe('string')
  })

  test('Slack signing secret to be string', async () => {
    let token =process.env.slack_signing_secret
    expect(typeof token).toBe('string')
  })

  test('Client signature to be string', async () => {
    let token =process.env.client_signature
    expect(typeof token).toBe('string')
  })