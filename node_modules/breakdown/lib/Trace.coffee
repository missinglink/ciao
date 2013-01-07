
StackTrace = require './StackTrace'
File = require './File'
CompiledCoffee = require './CompiledCoffee'
TokenMatcher = require './TokenMatcher'

class Trace

  constructor: (err) ->

    @error = err
    @stack = new StackTrace err.stack
    @message = err.message

    for line in @stack.lines

      try
        file = new File line.filename
      catch e
        file = {}

      if /\.js$/.test file.filename

        line.file = file

      else if /\.coffee$/.test file.filename

        line.file = file
        line.row = Number TokenMatcher.match file,
            ( new CompiledCoffee file.filename ).tokens[ line.row - 1 ]
        line.column = null

module.exports = Trace