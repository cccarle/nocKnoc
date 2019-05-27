let workspace = require('../utils/workspace')

let channels = await workspace.getChannels()
let teams = await workspace.getTeams()
let employees = await workspace.getEmployees()

// Channels
test('Get all channels as array', async () => {
  expect(Array.isArray(channels)).toBe(true)
})

test('Channel has id', async () => {
  expect(typeof channels[0].id).toBe('string')
})

test('Channel has name', async () => {
  expect(typeof channels[0].name).toBe('string')
})

// Teams
test('Get all teams as object', async () => {
  expect(Array.isArray(teams)).toBe(true)
})

test('Teams has id', async () => {
  expect(typeof teams[0].id).toBe('string')
})

test('Teams has name', async () => {
  expect(typeof teams[0].name).toBe('string')
})

// Employees
test('Get all employees as object', async () => {
  expect(Array.isArray(employees)).toBe(true)
})

test('Employee has id', async () => {

  expect(typeof employees[0].id).toBe('string')
})

test('Employee has name', async () => {

  expect(typeof employees[0].real_name).toBe('string')
})

test('Employee has image', async () => {

  expect(typeof employees[0].images).toBe('object')
})
