let {acceptDeclineMessage} = require('../resources/blocks')

test('acceptDecline block looks as it should', () => {
  let message = ''
  let blockMock = [
    {
      type: 'section',
      text: {
        type: 'mrkdwn',
        text: message
      }
    },
    {
      type: 'actions',
      block_id: 'feedback',
      elements: [
        {
          type: 'button',
          text: {
            type: 'plain_text',
            text: 'Accept'
          },
          value: 'true'
        },
        {
          type: 'button',
          text: {
            type: 'plain_text',
            text: 'Decline'
          },
          value: 'false'
        }
      ]
    }

  ]
  let result = acceptDeclineMessage(message)
  expect(result).toMatch(blockMock)
})
