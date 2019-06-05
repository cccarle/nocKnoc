let workspace = require('../utils/workspace')

// Channels
test('Get all channels as array', async () => {
  let channels = await workspace.getChannels()
  expect(Array.isArray(channels)).toBe(true)
})

test('Channel has id', async () => {
  let channels = await workspace.getChannels()
  expect(typeof channels[0].id).toBe('string')
})

test('Channel has name', async () => {
  let channels = await workspace.getChannels()
  expect(typeof channels[0].name).toBe('string')
})

// Teams
test('Get all teams as object', async () => {
  let teams = await workspace.getTeams()
  expect(Array.isArray(teams)).toBe(true)
})

test('Teams has id', async () => {
  let teams = await workspace.getTeams()
  expect(typeof teams[0].id).toBe('string')
})

test('Teams has name', async () => {
  let teams = await workspace.getTeams()
  expect(typeof teams[0].name).toBe('string')
})

// Employees
test('Get all employees as object', async () => {
  let employees = await workspace.getEmployees()
  expect(Array.isArray(employees)).toBe(true)
})

test('Employee has id', async () => {
  let employees = await workspace.getEmployees()
  expect(typeof employees[0].id).toBe('string')
})

test('Employee has name', async () => {
  let employees = await workspace.getEmployees()
  expect(typeof employees[0].real_name).toBe('string')
})

test('Employee has image', async () => {
  let employees = await workspace.getEmployees()
  expect(typeof employees[0].images).toBe('object')
})
