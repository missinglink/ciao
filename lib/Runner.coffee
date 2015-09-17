Process = require './Process'
path = require 'path'
coffee = path.resolve( __dirname + '/../node_modules/coffee-script/bin/coffee' )
EventEmitter = require('events').EventEmitter

class Runner extends EventEmitter

  constructor: (@groups) ->

    # Set environmental variables
    @env = process.env
    @env['NODE_PATH'] = path.resolve( __dirname + '/../node_modules' )

  complete: (error, request, response, body) =>

    if error then return @emit 'complete', 99, null, error
    if @groups.length == 0 then return @emit 'complete', 99, null, 'no groups'

    if !body || !response || !response.statusCode || !response.headers
      return @emit 'complete', 99, null, 'invalid response object'

    res =
      body: body
      statusCode: response.statusCode
      headers: response.headers

    for test in @groups

      script = []
      script.push "should = require 'should'"
      script.push "require 'should-http'"
      script.push "cheerio = require 'cheerio'"
      script.push "title = '" + test.title.split("'").join("\\'") + "'"
      script.push "response = " + JSON.stringify res
      script.push "try"
      script.push "  $ = {}"
      script.push "  json = JSON.parse(response.body)"
      script.push "catch e"
      script.push "  json = {}"
      script.push "  $ = cheerio.load(response.body)"
      script.push "try"
      script.push Runner.indentSource( test.source, ' ', 2 )
      script.push "catch e"
      script.push "  console.error e.message"
      script.push "  process.exit 1"
      script.push "process.exit 0"

      # Spawn child process
      child = new Process coffee, [ '-s' ], { env: @env }, { test: test, request: request, response: res }

      child.on 'exit', (code, stdout, stderr, data) =>
        @emit 'complete', code, stdout, stderr, data

      child.emit 'write', script.join '\n'

  @indentSource: (source='',char=' ',indentation=2) ->

    indent = Array(indentation+1).join(char)
    return indent + source.split("\n").join("\n#{indent}")

module.exports = Runner