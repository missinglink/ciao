
Runner = require './Runner'
firstrun = true
logger = console

# Standard Reporter
module.exports.standard = class StandardReporter
  constructor: ( @runner ) ->
    @runner.on 'complete', (code,stdout,stderr,data,log=console) =>

      logger = log if log

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

# Request / Response Reporter
module.exports.reqRes = class ReqRes
  constructor: ( @runner ) ->
    @runner.on 'complete', (code,stdout,stderr,data) =>
      unless code is 0
        logger.log '\n -- REQUEST -----------'
        logger.log JSON.stringify( data.request, null, 2 )
        logger.log '\n -- RESPONSE -----------'
        logger.log data.response.statusCode
        logger.log JSON.stringify( data.request.headers, null, 2 )
        foo = JSON.parse( data.response.body )
        logger.log JSON.stringify( foo, null, 2 )

# Debug Reporter
module.exports.debug = class Debug
  constructor: ( @runner ) ->
    @runner.on 'complete', (code,stdout,stderr,data) =>
      logger.log 'code', code
      logger.log 'stdout', stdout
      logger.log 'stderr', stderr
      logger.log 'data', data

# Request Reporter
module.exports.request = class Request
  constructor: ( @runner ) ->
    @runner.on 'complete', (code,stdout,stderr,data) =>
      logger.log data.request