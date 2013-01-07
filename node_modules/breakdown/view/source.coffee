
header = require './header'
_ = require 'underscore'

module.exports = (stackLine,settings={}) ->

  settings = _.extend { margin:3, title:undefined }, settings

  header stackLine, settings.title

  stackLine.row = Number( stackLine.row )

  for i in [(stackLine.row - settings.margin)..(stackLine.row + settings.margin)]

    if undefined != ( line = stackLine.file.lines[ i - 1 ] )

      line = line.substr( 0, 80 )

      if stackLine.row is Number i

        console.error " \x1b[1;31m✘\x1b[1;33m #{i}: \x1b[1;37m#{line}\x1b[0m"

      else

        console.error " \x1b[0;33m  #{i}: \x1b[1;30m#{line}\x1b[0m"