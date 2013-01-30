
firstrun = true

module.exports.standard = (code,stdout,stderr,data) =>

  # Hack for adding first newline
  if firstrun is true
    console.log ''
    firstrun = false

  console.log " ☕ \x1b[1m#{data.test.id} \x1b[0m"

  if code is 0
    console.log " \x1b[1;32m✓ #{data.test.title}\x1b[0m"

  else
    console.log " \x1b[1;31m✘ #{data.test.title}\x1b[0m"

  if stdout then console.log " \x1b[0m  #{stdout}\x1b[0m"
  if stderr then console.log " \x1b[0m  #{stderr}\x1b[0m"

  console.log ''