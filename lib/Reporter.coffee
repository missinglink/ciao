
module.exports = (code,stdout,stderr,data) =>

  console.log "-- #{data.test.file} --"

  if code is 0
    console.log "\x1b[1;32m✓ #{data.test.title}\x1b[0m"

  else
    console.log "\x1b[1;31m✘ #{data.test.title}\x1b[0m"
    console.log stdout

  console.log "\n"