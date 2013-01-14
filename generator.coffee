
fs = require 'fs'
walk = require 'walk'
CoffeeScript = require 'coffee-script'

Request = require './lib/Request'
TestRunner = require './lib/TestRunner'
ScriptParser = require './lib/ScriptParser'
Documentor = require './lib/Documentor'
Reporter = require './lib/Reporter'

# Get list of files recursively
files = []
walker = walk.walk './test', followLinks: false
walker.on 'file', (root,stat,next) ->
  files.push root + '/' + stat.name
  next()

walker.on 'end', ->

  for filename in files

    if fs.statSync filename

      script = new ScriptParser filename
      groups = script.parseGroups()

      unless groups[1] then throw new Error 'Ciao: Could not find request section, did you add a title comment?'
      req = CoffeeScript.eval groups[1].source

      unless req?.path and req?.method then throw new Error 'Ciao: Invalid request section, you must specify at least path & method'
      unless groups[2] then throw new Error 'Ciao: No test sections found'

      documentation = new Documentor groups[1].title, filename.replace /\.\/(test)\/(.+).coffee/, './doc/$2.md'

      runner = new TestRunner groups[2...]
      runner.listener Reporter
      runner.listener documentation.documentTest

      request = new Request()
      request.listener runner.complete
      request.listener documentation.documentTransaction

      request.transfer req

    else throw new Error 'Failed to stat file'