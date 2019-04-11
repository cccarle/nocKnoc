let api = require('../utils/slack/api')

test('Slack response test', async () => {
  let result = await api.testSlack()
  expect(result.ok).toBe(true)
})
