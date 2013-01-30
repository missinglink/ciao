fs = require 'fs'
ScriptParser = require './ScriptParser'
deepmerge = require 'deepmerge'
CoffeeScript = require 'coffee-script'
Settings = require './Settings'
Q = require 'q'

class RequestChain

  constructor: () ->
    @chain = []

  merge: (settings) =>
    @chain.push (prev) ->
      deepmerge prev, settings

  mergeScript: (script) =>
    @chain.push (prev) ->
      deepmerge prev, defaults: CoffeeScript.eval script

  run: () =>
    step = Q.fcall( () -> {} )
    step = step.then( (settings) => link settings ) for link in @chain
    step.then (settings) => @done settings

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
      chain.mergeScript "config = " + JSON.stringify(settings.config) + "\n\n" + section.source + '\n'

    chain.mergeScript "config = " + JSON.stringify(settings.config) + "\n\n" + parser.sections.request[0].source + '\n'

    chain.done = (settings) =>

      unless settings.defaults?.host then throw new Error 'FATAL: Invalid request section, you must specify a host'
      unless settings.defaults?.method then throw new Error 'FATAL: Invalid request section, you must specify a a method'
      unless settings.defaults?.path then throw new Error 'FATAL: Invalid request section, you must specify a path'

      cb settings, parser
    
    chain.run();

  done: (request) => console.log 'CiaoScript FAIL'

module.exports = CiaoScript