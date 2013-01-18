Process = require './Process'

class TestRunner

  constructor: (groups) ->

    @groups = groups
    @listeners = []

  complete: (error, request, response, body) =>

    throw new Error error if error

    for test in @groups

      script = "should = require 'should'" + "\n"
      script += "title = '" + test.title.split("'").join("\\'") + "'\n" #"mocha = require 'mocha'" + "\n"
      script += "`response = { 'body': " + JSON.stringify(body) + ", 'statusCode': " + JSON.stringify(response.statusCode) + ", 'headers': " + JSON.stringify(response.headers) + " }`" + "\n"
      script += "\n"
      script += "try" + "\n"
      script += TestRunner.indentSource( test.source, ' ', 2 ) + "\n"
      script += "catch e" + "\n"
      script += "  console.log e.message" + "\n"
      script += "  process.exit 1" + "\n"
      script += "process.exit 0" + "\n"
      script += "\n"

      # Spawn child process
      env = process.env
      env['NODE_PATH'] = process.cwd() + "/node_modules"

      child = new Process 'coffee', [ '-s' ], { env: env }, { test: test }

      child.on 'exit', (code, stdout, stderr, data) =>
        @listeners.map (listener) => listener code, stdout, stderr, data

      child.emit 'write', script

  listener: (callback) => @listeners.push callback

  @indentSource: (source,char=' ',indentation=2) ->

    indent = Array(indentation).join(' ')
    return indent + ( source + "\n" ).split("\n").join("\n#{indent}")


module.exports = TestRunner