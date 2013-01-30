
Runner = require './Runner'

firstrun = true

module.exports.standard = (code,stdout,stderr,data,logger=console) =>

  # Hack for adding first newline
  if firstrun is true
    logger.log ''
    firstrun = false

  r = data.request
  logger.log " \x1b[1m#{r.method} \x1b[1;0m#{r.protocol}//#{r.host}#{r.path}\x1b[0m" + " \x1b[2m#{data.test.id} \x1b[0m"

  if code is 0
    logger.log " \x1b[1;32m✓\x1b[0;32m #{data.test.title}\x1b[0m"

  else
    logger.log " \x1b[1;31m✘\x1b[1;31m #{data.test.title}\x1b[0m"

  if stdout
    stdout = stdout.replace /^\s+|\s+$/g, ''
    logger.log " \x1b[0m#{stdout}\x1b[0m"

  if stderr
    stderr = stderr.replace /^\s+|\s+$/g, ''
    logger.log " \x1b[1;33m#{stderr}\x1b[0m"

    # debug = Runner.indentSource data.test.source, '\x1b[1m  #? \x1b[0m', 1
    # logger.log '\n' + debug

  logger.log ''

module.exports.debug = (code,stdout,stderr,data) =>

  logger.log 'code', code
  logger.log 'stdout', stdout
  logger.log 'stderr', stderr
  logger.log 'data', data

module.exports.request = (code,stdout,stderr,data) =>

  logger.log data.request