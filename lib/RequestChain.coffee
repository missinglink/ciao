
CoffeeScript = require 'coffee-script'
Process = require './Process'
Runner = require './Runner'
async = require 'async'
path = require 'path'

class RequestChain

  constructor: (@settings={}) ->
    @chain = []

    # Set environmental variables
    @env = process.env
    @env['NODE_PATH'] = path.resolve( __dirname + '/../node_modules' )

  merge: (settings) =>
    @chain.push (prev) ->
      prev.merge settings

  mergeScriptEval: (source) =>
    @chain.push (prev,callback) =>

      script = []
      script.push "config = " + JSON.stringify( prev.config or {} )
      script.push ''
      script.push source
      script.push ''

      try
        result = CoffeeScript.eval script.join '\n'
        throw new Error 'Invalid request / before block' unless typeof result is 'object'
        return callback null, defaults: result, config: {}
      catch e
        console.log '[PARSER ERROR] ' + e.message
        return callback null, { defaults: {}, config: {} }

  mergeScriptProcess: (source) =>
    @chain.push (prev,callback) =>

      script = []
      script.push "config = " + JSON.stringify( prev.config or {} )
      script.push ''
      script.push "try"
      script.push "  console.log( JSON.stringify( "
      script.push Runner.indentSource( source, ' ', 4 )
      script.push "  ))"
      script.push "  process.exit 0"
      script.push "catch e"
      script.push "  console.error e.message"
      script.push "  process.exit 1"
      script.push ''

      # Spawn child process
      child = new Process path.resolve( __dirname + '/../node_modules/coffee-script/bin/coffee' ), [ '-s' ], { env: @env }

      child.on 'exit', (code, stdout, stderr) =>

        if stderr
          # console.error stderr
          return callback stderr

        try
          result = JSON.parse stdout
          throw new Error 'Invalid request / before block' unless typeof result is 'object'
          return callback null, defaults: result, config: {}
        catch e
          # console.log 'ERR', stderr
          # console.log stdout
          # console.log script.join '\n'
          throw e
          return callback null, { defaults: {}, config: {} }

      child.on 'error', console.log
      child.emit 'write', script.join '\n'

  run: () =>

    async.parallel @chain.map( (link) => return (callback) => link @settings, callback ),
      (err, results) =>
        throw new Error err if err
        results.map (result) => @settings.merge result
        @done @settings

  done: () => console.log 'RequestChain FAIL'

module.exports = RequestChain