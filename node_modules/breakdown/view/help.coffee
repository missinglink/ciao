path = require 'path'
header = require './header'
source = require './source'

File = require '../lib/File'

StackTraceLine = require '../lib/StackTraceLine'

module.exports = (trace) ->

  file = path.basename trace.stack.lines[0].file.filename
  stack = trace.error.stack.split "\n"

  for ordinal, line of stack
    if 0 is Number ordinal

      switch line.replace /^([^:]+):(.+)/, "$1"

        when 'ReferenceError'

          if typo = line.replace( /^([^:]+): (.+) is not defined/, "\x1b[1m'$2'\x1b[0m " ) || ''
            row = trace.stack.lines[0].row
            console.error "\x1b[1;34m Help:\x1b[0m"
            console.error "  \x1b[0m Spelling mistake #{typo}at \x1b[1;33m#{file}\x1b[0m:\x1b[1;34m#{row}\x1b[0m"
            console.error "  \x1b[0m Missing a require() statement for #{typo}\x1b[0m"
            console.log()

        when 'TypeError'

          if typo = line.replace( /^([^:]+): Cannot read property '(.+)' of undefined/, "\x1b[1m'$2'\x1b[0m " ) || ''
            row = trace.stack.lines[0].row
            console.error "\x1b[1;34m Help:\x1b[0m"
            console.error "  \x1b[0m The parent of #{typo}is undefined at \x1b[1;33m#{file}\x1b[0m:\x1b[1;34m#{row}\x1b[0m"
            console.log()

        when 'Error'

          [ {}, filename, lineno, token ] = line.match(/Error: In (.+), Parse error on line (\w+): Unexpected '(.+)'/) || []

          if filename

            filename = filename.replace process.cwd(), '.'

            console.error "\x1b[1;34m Help:\x1b[0m"
            console.error "  \x1b[0m Invalid coffee-script syntax at \x1b[1;33m#{filename}\x1b[0m:\x1b[1;34m#{lineno}\x1b[0m"
            console.error "  \x1b[0m Inconsistent coffee-script indentation in \x1b[1;33m#{filename}\x1b[0m"

            console.log()
            newtrace = new StackTraceLine "(#{filename}:#{lineno}:0)"
            newtrace.file = new File filename
            source newtrace, title: 'Related'
            console.log()

