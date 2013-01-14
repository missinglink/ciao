
fs = require 'fs'
CoffeeScript = require 'coffee-script'

Request = require './lib/Request'
TestRunner = require './lib/TestRunner'
ScriptParser = require './lib/ScriptParser'

for reqFile in [ './test/01.coffee', './test/02.coffee' ]

  if fs.statSync reqFile

    script = new ScriptParser reqFile
    groups = script.parseGroups()

    unless groups[1] then throw new Error 'Ciao: Could not find request section, did you add a title comment?'
    req = CoffeeScript.eval groups[1].source

    unless req?.path and req?.method then throw new Error 'Ciao: Invalid request section, you must specify at least path & method'
    unless groups[2] then throw new Error 'Ciao: No test sections found'

    runner = new TestRunner groups[2...]
    
    request = new Request()
    request.transfer req, runner.complete

  else throw new Error 'Failed to stat file'
