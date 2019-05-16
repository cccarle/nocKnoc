const fs = require("fs").promises

const readFileTwo = () => {
let file = fs.readFile(
    "resources/settings.json",
    "utf8",
    function (err, data) {
      if (err) {
        console.log(err)
      }
      console.log(JSON.parse(data))
      
    }
  )
  console.log(file)
  return file
}
const readFile = () => {
    return fs.readFile('resources/settings.json','utf8', (err, data) => {
        if (err) throw err;
        JSON.parse(data)
    });
}

module.exports = {
    readFile
}