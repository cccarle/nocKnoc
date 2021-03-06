let api = require('../utils/slack/api')

// Test function
test('Slack response test', async () => {
  let result = await api.testSlack()
  expect(result.ok).toBe(true)
})

// getAllUsers
test('Users to be object', async () => {
  let result = await api.getAllUsers()
  expect(typeof result).toBe('object')
})

// getUserById
test('Get user from workspace by id without id', () => {
  expect(
      api.getUserById()
  ).rejects.toMatch('error')
})

test('Get user from workspace by id with wrong id', () => {
  let id = 'thisIsNotAValidId'
  expect(
      api.getUserById(id)
  ).rejects.toMatch('error')
})


test('Get channel from workspace by id without id', () => {
  expect(
      api.getChannelById()
  ).rejects.toMatch('error')
})

test('Get channel from workspace by id with wrong id', () => {
  let id = 'thisIsNotAValidId'
  expect(
      api.getChannelById(id)
  ).rejects.toMatch('error')
})
