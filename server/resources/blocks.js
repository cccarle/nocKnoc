exports.acceptDeclineMessage = (message, value = 'true', channel = 'true') => {
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
        value: `${value} ${channel}`
        },
      ]
    }

  ]
  return JSON.stringify(arr)
}
