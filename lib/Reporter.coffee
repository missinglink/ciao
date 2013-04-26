
Runner = require './Runner'
firstrun = true
logger = console

# Suite Reporter
class Suite
  constructor: () ->
    @startTime = new Date()
    @totalTests = 0
    @testcases = []

    process.stdout.write ' '

  watch: ( @runner ) =>

    reporter = new StandardReporter()

    @runner.on 'start', => @totalTests++
    @runner.on 'complete', (code,stdout,stderr,data) =>

      process.stdout.write ( if code is 0 then '.' else 'E' )

      @testcases.push
        code: code
        stdout: stdout
        stderr: stderr
        data: data

      if @testcases.length >= @totalTests
        elapsedTime = ( new Date() ).getTime() - @startTime.getTime()
        
        pass = 0
        fail = 0
        output = ''

        console.log '\n'
        console.log ' Time: ' + ( elapsedTime / 1000 ).toFixed(2) + ' seconds'

        for test in @testcases
          if test.code is 0
            pass++
          else
            reporter.log test.code, test.stdout, test.stderr, test.data
            fail++

        console.log ' Tests: ' + @testcases.length + ', Errors: ' + fail
        console.log ''

        if fail > 0 then process.exit 1

# Standard Reporter
class StandardReporter
  watch: ( @runner ) ->
    @runner.on 'complete', @log

  log: (code,stdout,stderr,data,mocklogger) =>

    logger = mocklogger if mocklogger

    # Hack for adding first newline
    if firstrun is true
      logger.log ''
      firstrun = false

    r = data.request
    logger.log " \x1b[1m#{r.method.toUpperCase()} \x1b[1;0m#{r.protocol}//#{r.host}:#{r.port}#{r.path}\x1b[0m" + " \x1b[2m#{data.test.id} \x1b[0m"

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
class ReqRes
  watch: ( @runner ) ->
    @runner.on 'complete', (code,stdout,stderr,data) =>
      logger.log '\n -- REQUEST -----------'
      logger.log JSON.stringify( data.request, null, 2 )
      logger.log '\n -- RESPONSE -----------'
      logger.log data.response.statusCode
      logger.log JSON.stringify( data.request.headers, null, 2 )
      foo = JSON.parse( data.response.body )
      logger.log JSON.stringify( foo, null, 2 )

# Debug Reporter
class Debug
  watch: ( @runner ) ->
    @runner.on 'complete', (code,stdout,stderr,data) =>
      logger.log 'code', code
      logger.log 'stdout', stdout
      logger.log 'stderr', stderr
      logger.log 'data', data

# Request Reporter
class Request
  watch: ( @runner ) ->
    @runner.on 'complete', (code,stdout,stderr,data) =>
      logger.log data.request

module.exports = {
  suite: Suite,
  standard: StandardReporter,
  reqRes: ReqRes,
  debug: Debug,
  request: Request
}
