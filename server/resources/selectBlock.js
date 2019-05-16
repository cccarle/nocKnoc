exports.selectBlock = (teamName, value, option) => {
  let blockObject = {
    type: "section",
    text: {
      type: "mrkdwn",
      text: teamName
    },
    accessory: {
      type: "button",
      text: {
        type: "plain_text",
        text: option,
        emoji: true
      },
      value: value
    }
  }
  
  


  return blockObject
}
