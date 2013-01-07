path = require 'path'

module.exports = (stackLine,title) ->

  filename = stackLine.filename.replace process.cwd(), '.'
  console.error "\x1b[1;34m #{title}:\x1b[1;33m #{filename}\x1b[33m\x1b[0m:\x1b[1;34m#{stackLine.row}\x1b[0m"