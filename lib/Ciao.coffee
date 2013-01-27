
fs = require 'fs'
walk = require 'walk'
CoffeeScript = require 'coffee-script'

Request = require './Request'
TestRunner = require './TestRunner'
ScriptParser = require './ScriptParser'
Documentor = require './Documentor'
Reporter = require './Reporter'

deepmerge = require 'deepmerge'

class Ciao

  constructor: (settings) ->

    unless settings?.testDir? then throw new Error 'Ciao: Invalid test directory'
    unless settings?.docDir? then throw new Error 'Ciao: Invalid documentation directory'
    settings.config = {} unless 'object' is typeof settings.config

    # Get list of files recursively
    files = []
    walker = walk.walk settings.testDir, followLinks: false
    walker.on 'file', (root,stat,next) ->
      files.push root + '/' + stat.name
      next()

    walker.on 'end', ->

      for filename in files

        if fs.statSync filename

          parser = new ScriptParser fs.readFileSync filename

          if parser.sections.request.length < 1 
            throw new Error 'FATAL: You must define a request section'

          if parser.sections.request.length > 1
            console.error 'WARNING: You may only have one request section per script'

          req = settings.defaults or {}

          for section in [ 'auth', 'request' ]
            for config in parser.sections[section]
              script = "config = " + JSON.stringify(settings.config) + "\n" + config.source
              req = deepmerge req, CoffeeScript.eval script

          unless req?.host then throw new Error 'FATAL: Invalid request section, you must specify a host'
          unless req?.method then throw new Error 'FATAL: Invalid request section, you must specify a a method'
          unless req?.path then throw new Error 'FATAL: Invalid request section, you must specify a path'

          unless parser.sections.assert[0] then throw new Error 'FATAL: No test sections found'

          docFile = filename.replace settings.testDir, settings.docDir
          docFile = docFile.replace '.coffee', '.md'

          documentation = new Documentor parser.sections.request[0].title, docFile

          runner = new TestRunner parser.sections.assert
          runner.listener Reporter
          runner.listener documentation.documentTest

          request = new Request()
          request.listener runner.complete
          request.listener documentation.documentTransaction

          request.transfer req

        else throw new Error 'Failed to stat file'

module.exports = Ciao