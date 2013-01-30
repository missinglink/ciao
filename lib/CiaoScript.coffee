fs = require 'fs'
ScriptParser = require './ScriptParser'
Settings = require './Settings'
RequestChain = require './RequestChain'

class CiaoScript

  @load: ( filename, settings, callback ) ->

    throw new Error 'Invalid settings' unless settings and settings instanceof Settings

    throw new Error 'Failed to stat file' unless fs.statSync filename
    parser = new ScriptParser fs.readFileSync(filename), filename

    if parser.sections.request.length < 1
      throw new Error 'FATAL: You must define a request section in: ' + filename

    if parser.sections.request.length > 1
      console.error 'WARNING: You may only have one request section per script in: ' + filename

    unless parser.sections.assert[0] then throw new Error 'FATAL: No assert blocks found'

    chain = new RequestChain()
    chain.merge settings
    parser.sections.auth.map ( section ) -> chain.mergeScriptProcess section.source
    chain.mergeScriptProcess parser.sections.request[0].source

    chain.done = ( settings ) =>

      unless settings.defaults?.host
        throw new Error 'FATAL: Invalid request section, you must specify a host'

      unless settings.defaults?.method
        throw new Error 'FATAL: Invalid request section, you must specify a a method'

      unless settings.defaults?.path
        throw new Error 'FATAL: Invalid request section, you must specify a path'

      callback settings, parser
    
    chain.run();

  done: (request) => console.log 'CiaoScript FAIL'

module.exports = CiaoScript