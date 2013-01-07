
StackTraceLine = require './StackTraceLine'

class StackTrace

  constructor: ( stack ) ->

    @lines = []
    stack.split( "\n" ).map ( line ) =>
      trace = new StackTraceLine line
      @lines.push trace if trace.filename

module.exports = StackTrace