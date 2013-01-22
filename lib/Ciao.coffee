
fs = require 'fs'
walk = require 'walk'
CoffeeScript = require 'coffee-script'

Request = require './Request'
TestRunner = require './TestRunner'
ScriptParser = require './ScriptParser'
Documentor = require './Documentor'
Reporter = require './Reporter'

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

          script = new ScriptParser filename
          groups = script.parseGroups()

          unless groups[1] then throw new Error 'Ciao: Could not find request section, did you add a title comment?'

          script = "config = " + JSON.stringify(settings.config) + "\n"
          script += groups[1].source

          req = CoffeeScript.eval script

          unless req?.path and req?.method then throw new Error 'Ciao: Invalid request section, you must specify at least path & method'
          unless groups[2] then throw new Error 'Ciao: No test sections found'

          docFile = filename.replace settings.testDir, settings.docDir
          docFile = docFile.replace '.coffee', '.md'

          documentation = new Documentor groups[1].title, docFile

          runner = new TestRunner groups[2...]
          runner.listener Reporter
          runner.listener documentation.documentTest

          request = new Request()
          request.listener runner.complete
          request.listener documentation.documentTransaction

          request.transfer req

        else throw new Error 'Failed to stat file'

module.exports = Ciao