Process = require './Process'
Reporter = require './Reporter'

class TestRunner

  constructor: (groups) ->

    @groups = groups

  complete: (error, response, body) =>

    throw new Error error if error

    for test in @groups

      script = "title = '" + test.title + "'\n" #"mocha = require 'mocha'" + "\n"
      script += "`response = { 'body': " + JSON.stringify(body) + ", 'statusCode': " + JSON.stringify(response.statusCode) + ", 'headers': " + JSON.stringify(response.headers) + " }`" + "\n"
      script += "\n"
      script += "try" + "\n"
      script += TestRunner.indentSource( test.source, ' ', 2 ) + "\n"
      script += "catch e" + "\n"
      script += "  console.log e.message" + "\n"
      script += "  process.exit 1" + "\n"
      script += "process.exit 0" + "\n"
      script += "\n"

      # console.log script

      env = process.env
      env['NODE_PATH'] = process.cwd() + "/node_modules"

      child = new Process 'coffee', [ '-s', '-r', 'should' ], { env: env }, { test: test }
      child.on 'exit', Reporter
      child.emit 'write', script


  @indentSource: (source,char=' ',indentation=2) ->

    indent = Array(indentation).join(' ')
    return indent + ( source + "\n" ).split("\n").join("\n#{indent}")


module.exports = TestRunner