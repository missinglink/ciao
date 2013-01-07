path = require 'path'

module.exports = (trace) ->

  errorstack = trace.error.stack.split("\n")

  title = errorstack[0].replace process.cwd(), '.'
  console.error title.replace(/^(\w+): /, " \x1b[1;34m$1:\x1b[0m \x1b[1;33m") + "\x1b[0m "

  for ordinal, line of errorstack[1..]

    output = line

    trace.stack.lines.map (stackLine) ->

      filename = stackLine.filename.replace /(.+)/, "\x1b[0;33m$1\x1b[0m"

      basename = path.basename stackLine.filename
      filename = filename.replace basename, "\x1b[1;33m#{basename}\x1b[0m"

      if not stackLine.column
        output = output.replace stackLine.line, "\x1b[0;33m#{filename}\x1b[0m:\x1b[1;34m#{stackLine.row}\x1b[0m"

      else output = output.replace stackLine.line, "\x1b[0;33m#{filename}\x1b[0m:#{stackLine.row}:#{stackLine.column}\x1b[0m"

    output = output.replace process.cwd(), '.'
    output = output.replace /\((.+)\)/, "$1"
    output = output.replace /^(\s+)at ([^\s]+)/, "\x1b[1m   $2()\x1b[0m"
    output = output.replace /([^\/]+\.\w+):/, "\x1b[1m$1\x1b[0m:"
    console.error output

  #console.error stack.replace /\d+:\d+/, "\x1b[1;34m#{trace.coffee.line}\x1b[0m"