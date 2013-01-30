
firstrun = true

module.exports.standard = (code,stdout,stderr,data) =>

  # console.log data.request
  r = data.request
  # console.log " > \x1b[1m#{r.method} #{r.host}#{r.path}\x1b[0m"

  # Hack for adding first newline
  if firstrun is true
    console.log ''
    firstrun = false

  console.log " \x1b[1;33m#{r.method} \x1b[0;33m#{r.host}#{r.path}\x1b[0m" + " \x1b[2m#{data.test.id} \x1b[0m"

  if code is 0
    console.log " \x1b[1;32m✓\x1b[0;32m #{data.test.title}\x1b[0m"

  else
    console.log " \x1b[1;31m✘\x1b[0;32m #{data.test.title}\x1b[0m"

  if stdout then console.log " \x1b[0m#{stdout}\x1b[0m"
  if stderr then console.log " \x1b[31m#{stderr}\x1b[0m"

  console.log ''