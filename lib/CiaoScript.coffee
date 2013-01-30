fs = require 'fs'
ScriptParser = require './ScriptParser'
deepmerge = require 'deepmerge'
CoffeeScript = require 'coffee-script'
Settings = require './Settings'
Q = require 'q'
Process = require './Process'
Runner = require './Runner'

class RequestChain

  constructor: () ->
    @chain = []

    # Set environmental variables
    @env = process.env
    @env['NODE_PATH'] = process.cwd() + '/node_modules'

  merge: (settings) =>
    @chain.push (prev) ->
      deepmerge prev, settings

  mergeScript: (source) =>
    @chain.push (prev) =>

      script = []
      script.push "config = " + JSON.stringify( prev.config or {} )
      script.push ''
      script.push "try"
      script.push "  console.log( JSON.stringify( "
      script.push Runner.indentSource( source, ' ', 4 )
      script.push "  ))"
      script.push "catch e"
      script.push "  console.log e.message"
      script.push "  process.exit 1"
      script.push "process.exit 0"

      deferred = Q.defer();

      # Spawn child process
      child = new Process 'node_modules/coffee-script/bin/coffee', [ '-s' ], { env: @env }

      child.on 'exit', (code, stdout, stderr) =>
        deferred.resolve deepmerge prev, defaults: JSON.parse stdout

      child.on 'error', console.log
      child.emit 'write', script.join '\n'

      return deferred.promise

  run: () =>
    step = Q.fcall( () -> {} )
    step = step.then( link ) for link in @chain
    step.then @done

  done: () => console.log 'RequestChain FAIL'

class CiaoScript

  @load: (filename,settings,cb) ->

    throw new Error 'Invalid settings' unless settings and settings instanceof Settings

    throw new Error 'Failed to stat file' unless fs.statSync filename
    parser = new ScriptParser fs.readFileSync(filename), filename

    if parser.sections.request.length < 1
      console.log filename
      throw new Error 'FATAL: You must define a request section'

    if parser.sections.request.length > 1
      console.log filename
      console.error 'WARNING: You may only have one request section per script'

    unless parser.sections.assert[0] then throw new Error 'FATAL: No assert blocks found'

    chain = new RequestChain()
    chain.merge settings

    for section in parser.sections.auth
      chain.mergeScript section.source

    chain.mergeScript parser.sections.request[0].source

    chain.done = (settings) =>

      unless settings.defaults?.host then throw new Error 'FATAL: Invalid request section, you must specify a host'
      unless settings.defaults?.method then throw new Error 'FATAL: Invalid request section, you must specify a a method'
      unless settings.defaults?.path then throw new Error 'FATAL: Invalid request section, you must specify a path'

      cb settings, parser
    
    chain.run();

  done: (request) => console.log 'CiaoScript FAIL'

module.exports = CiaoScript