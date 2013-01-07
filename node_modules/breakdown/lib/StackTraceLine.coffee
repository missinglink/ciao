
class StackTraceLine
  
  constructor: ( line ) -> [ {}, @line, @filename, @row, @column ] = line.match( /\(((.*):(\d+):(\d+))\)/ ) or []

module.exports = StackTraceLine