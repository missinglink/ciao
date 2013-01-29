fs = require 'fs'
ScriptParser = require './ScriptParser'
deepmerge = require 'deepmerge'
CoffeeScript = require 'coffee-script'

class CiaoScript

  constructor: (@filename,settings) ->

    throw new Error 'Failed to stat file' unless fs.statSync @filename
    @parser = new ScriptParser fs.readFileSync @filename

    if @parser.sections.request.length < 1 
      throw new Error 'FATAL: You must define a request section'

    if @parser.sections.request.length > 1
      console.error 'WARNING: You may only have one request section per script'

    @request = settings.defaults or {}

    for config in @parser.sections.auth
      script = "config = " + JSON.stringify(settings.config) + "\n\n" + config.source
      @request = deepmerge @request, CoffeeScript.eval script

    script = "config = " + JSON.stringify(settings.config) + "\n\n" + @parser.sections.request[0].source
    @request = deepmerge @request, CoffeeScript.eval script

    unless @request?.host then throw new Error 'FATAL: Invalid request section, you must specify a host'
    unless @request?.method then throw new Error 'FATAL: Invalid request section, you must specify a a method'
    unless @request?.path then throw new Error 'FATAL: Invalid request section, you must specify a path'
    unless @parser.sections.assert[0] then throw new Error 'FATAL: No test sections found'

module.exports = CiaoScript