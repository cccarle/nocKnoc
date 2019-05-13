exports.acceptDeclineMessage = (teamName, value, option) => {
    let arr = [
      {
		type: "section",
		text: {
			type: "mrkdwn",
			text: teamName
		},
		accessory: {
			type: "static_select",
			placeholder: {
				type: "plain_text",
				text: "Change setting",
				emoji: true
			},
			options: [
				{
					text: {
						type: "plain_text",
						text: option,
						emoji: true
					},
					value: !value
				},
            ]
        }
    }

    ]
    return JSON.stringify(arr)
}