let employees = require('../controllers/employeesContoller')

test('Get all empoloyees as object', async () => {
  let result = await employees.getAll()
  expect(Array.isArray(result)).toBe(true)
})

test('Employee has id', async () => {
  let result = await employees.getAll()
  expect(typeof result[0].id).toBe('string')
})

test('Employee has name', async () => {
  let result = await employees.getAll()
  expect(typeof result[0].real_name).toBe('string')
})

test('Employee has image', async () => {
  let result = await employees.getAll()
  expect(typeof result[0].images).toBe('object')
})
