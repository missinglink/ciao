
fs = require 'fs'

class File

  constructor: ( @filename ) ->

    @read() and @parse() and @tokenize()

  read: () =>

    @source = fs.readFileSync( @filename ).toString 'utf8'

  parse: () =>

    @lines = @source.split /\n/

  tokenize: () =>
    
    @tokens = @lines.map (line) ->
      line.split(/[,\{\}\(\)\t ]+/).filter (p) -> p and p.length

module.exports = File