
Runner = require './Runner'

firstrun = true

module.exports.standard = (code,stdout,stderr,data) =>

  # Hack for adding first newline
  if firstrun is true
    console.log ''
    firstrun = false

  r = data.request
  console.log " \x1b[1m#{r.method} \x1b[1;0m#{r.protocol}//#{r.host}#{r.path}\x1b[0m" + " \x1b[2m#{data.test.id} \x1b[0m"

  if code is 0
    console.log " \x1b[1;32m✓\x1b[0;32m #{data.test.title}\x1b[0m"

  else
    console.log " \x1b[1;31m✘\x1b[0;32m #{data.test.title}\x1b[0m"

  if stdout
    stdout = stdout.replace /^\s+|\s+$/g, ''
    console.log " \x1b[0m#{stdout}\x1b[0m"

  if stderr
    stderr = stderr.replace /^\s+|\s+$/g, ''
    console.log " \x1b[31m#{stderr}\x1b[0m"

    debug = Runner.indentSource data.test.source, ' #? ', 1
    console.log "\x1b[1m#{debug}\x1b[0m"

  console.log ''

module.exports.debug = (code,stdout,stderr,data) =>

  console.log 'code', code
  console.log 'stdout', stdout
  console.log 'stderr', stderr
  console.log 'data', data

module.exports.request = (code,stdout,stderr,data) =>

  console.log data.request