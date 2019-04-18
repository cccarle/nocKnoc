exports.acceptDeclineMessage = (message) => {
  let arr = [
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
  return JSON.stringify(arr)
}
