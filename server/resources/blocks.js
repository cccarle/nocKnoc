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
      response_url: "https://77318323.ngrok.io/payload",
      elements: [
        {
          type: 'button',
          text: {
            type: 'plain_text',
            text: 'Accept'
          },
          url: 'https://api.slack.com/block-kit',
          value: 'true',
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
