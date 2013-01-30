
CoffeeScript = require 'coffee-script'
Q = require 'q'
Process = require './Process'
Runner = require './Runner'
merge = require 'deepmerge'

class RequestChain

  constructor: (@settings) ->
    @chain = []

    # Set environmental variables
    @env = process.env
    @env['NODE_PATH'] = process.cwd() + '/node_modules'

  merge: (settings) =>
    @chain.push (prev) ->
      prev.merge settings

  mergeScriptEval: (source) =>
    @chain.push (prev) =>

      script = []
      script.push "config = " + JSON.stringify( prev.config or {} )
      script.push ''
      script.push source
      script.push ''

      try
        result = CoffeeScript.eval script.join '\n'
        throw new Error 'Invalid request / before block' unless typeof result is 'object'
        return prev.merge defaults: result
      catch e
        console.log '[PARSER ERROR] ' + e.message
        return prev

  mergeScriptProcess: (source) =>
    @chain.push (prev) =>

      script = []
      script.push "config = " + JSON.stringify( prev.config or {} )
      script.push ''
      script.push "try"
      script.push "  console.log( JSON.stringify( "
      script.push Runner.indentSource( source, ' ', 4 )
      script.push "  ))"
      script.push "  process.exit 0"
      script.push "catch e"
      script.push "  console.log e.message"
      script.push "  process.exit 1"
      script.push ''

      deferred = Q.defer();

      # Spawn child process
      child = new Process 'node_modules/coffee-script/bin/coffee', [ '-s' ], { env: @env }

      child.on 'exit', (code, stdout, stderr) =>

        try
          result = JSON.parse stdout
          throw new Error 'Invalid request / before block' unless typeof result is 'object'
          deferred.resolve prev.merge defaults: result
        catch e
          console.log stdout
          console.log script.join '\n'
          console.log '[PARSER ERROR] ' + e.message
          deferred.resolve prev

      child.on 'error', console.log
      child.emit 'write', script.join '\n'

      return deferred.promise

  run: () =>
    step = Q.fcall( () => @settings )
    step = step.then( link ) for link in @chain
    step.then @done

  done: () => console.log 'RequestChain FAIL'

module.exports = RequestChain