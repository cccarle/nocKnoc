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
      block_id: 'feednack',
      elements: [
        {
          type: 'button',
          text: {
            type: 'plain_text',
            text: 'Accept'
          },
          url: 'https://api.slack.com/block-kit',
          value: 'true'
        },
        {
          type: 'button',
          text: {
            type: 'plain_text',
            text: 'Decline'
          }
        }
      ]
    }

  ]
  return JSON.stringify(arr)
}
