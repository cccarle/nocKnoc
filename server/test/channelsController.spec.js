let channel = require('../controllers/channelsController')

test('Get all channels as object', async () => {
  let result = await channel.getAll()
  expect(Array.isArray(result)).toBe(true)
})

test('Channel has id', async () => {
  let result = await channel.getAll()
  expect(typeof result[0].id).toBe('string')
})

test('Channel has name', async () => {
  let result = await channel.getAll()
  expect(typeof result[0].name).toBe('string')
})
