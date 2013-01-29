
fs = require 'fs'
walk = require 'walk'
CoffeeScript = require 'coffee-script'

Request = require './Request'
TestRunner = require './TestRunner'

Documentor = require './Documentor'
Reporter = require './Reporter'
CiaoScript = require './CiaoScript'
Settings = require './Settings'

class Ciao

  constructor: (settings=new Settings) ->

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

        script = new CiaoScript filename, settings

        docFile = ( filename.replace settings.testDir, settings.docDir ).replace '.coffee', '.md'
        documentation = new Documentor script.parser.sections.request[0].title, docFile

        runner = new TestRunner script.parser.sections.assert
        runner.listener Reporter
        runner.listener documentation.documentTest

        request = new Request()
        request.listener runner.complete
        request.listener documentation.documentTransaction

        request.transfer script.request

module.exports = Ciao