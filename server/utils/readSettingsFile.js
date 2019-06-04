const fs = require("fs").promises

const readFile = () => {
  return fs.readFile("resources/settings.json", "utf8", (err, data) => {
    if (err) throw err
    data
  }).then(data => JSON.parse(data))
  
}

const writeToFile = (settings) => {
    let json = JSON.stringify(settings)
    return fs.writeFile("resources/settings.json", json, "utf8", (err, data) => {
        if (err) {
          console.log(err)
        } 
      })
}

module.exports = {
  readFile,
  writeToFile
}
