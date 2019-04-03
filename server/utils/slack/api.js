var Slack = require('slack')
require('dotenv').config()

const token = process.env.Bot_User_OAuth_Access_Token

let bot = new Slack({token})

module.exports = {
  testSlack: async () => {
    return result = await bot.api.test({hyper: 'card', hej: 'bye'})
  },
  getAllUsers: async () => {
    return await bot.users.list()
  },
  getAllChannels: async () => {
    return await bot.channels.list()
  },
  sendMessageToChannel: async (channel, text) => {
    return await bot.chat.postMessage({token, channel: 'CHK464ERK', text: 'Hello World!'})
  },
  sendFormToChannel: async (dialog, triggerId) => {
    let array = [
      {
        'type': 'section',
        'text': {
          'type': 'mrkdwn',
          'text': 'This is a section block with a button.'
        },
        'accessory': {
          'type': 'button',
          'text': {
            'type': 'plain_text',
            'text': 'Click Me'
          },
          'value': 'click_me_123',
          'action_id': 'button'
        }
      },
      {
        'type': 'actions',
        'block_id': 'actionblock789',
        'elements': [
          {
            'type': 'button',
            'text': {
              'type': 'plain_text',
              'text': 'Link Button'
            },
            'url': 'https://api.slack.com/block-kit'
          }
        ]
      },
      {
        'type': 'actions',
        'elements': [
          {
            'type': 'button',
            'text': {
              'type': 'plain_text',
              'text': 'Button',
              'emoji': true
            },
            'value': 'click_me_123'
          }
        ]
      },
      {
        'type': 'actions',
        'elements': [
          {
            'type': 'conversations_select',
            'placeholder': {
              'type': 'plain_text',
              'text': 'Select a conversation',
              'emoji': true
            }
          },
          {
            'type': 'channels_select',
            'placeholder': {
              'type': 'plain_text',
              'text': 'Select a channel',
              'emoji': true
            }
          },
          {
            'type': 'users_select',
            'placeholder': {
              'type': 'plain_text',
              'text': 'Select a user',
              'emoji': true
            }
          },
          {
            'type': 'static_select',
            'placeholder': {
              'type': 'plain_text',
              'text': 'Select an item',
              'emoji': true
            },
            'options': [
              {
                'text': {
                  'type': 'plain_text',
                  'text': 'Excellent item 1',
                  'emoji': true
                },
                'value': 'value-0'
              },
              {
                'text': {
                  'type': 'plain_text',
                  'text': 'Fantastic item 2',
                  'emoji': true
                },
                'value': 'value-1'
              },
              {
                'text': {
                  'type': 'plain_text',
                  'text': 'Nifty item 3',
                  'emoji': true
                },
                'value': 'value-2'
              },
              {
                'text': {
                  'type': 'plain_text',
                  'text': 'Pretty good item 4',
                  'emoji': true
                },
                'value': 'value-2'
              }
            ]
          }
        ]
      }
    ]
    let attachments = array
    return await bot.chat.postMessage({token, channel: 'CHK464ERK', text: 'hej', blocks: attachments})
  }

}
