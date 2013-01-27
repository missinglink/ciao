
module.exports = (code,stdout,stderr,data) =>

  if code is 0
    console.log " \x1b[1;32m✓ #{data.test.title}\x1b[0m"

  else
    console.log " \x1b[1;31m✘ #{data.test.title}\x1b[0m"

  if stdout then console.log 'stdout', stdout
  if stderr then console.log 'stderr', stderr