Script = require 'lib/Script'
should = require 'should'
fs = require 'fs'
Settings = require 'lib/Settings'

describe 'Script', ->

  describe 'constructor', ->

    settings = new Settings();

    it 'should throw unless settings are provided', ->

      construct = -> Script.load ''
      construct.should.throw "Invalid settings"

    it 'should throw on invalid file', ->

      construct = -> Script.load 'not/existing', settings
      construct.should.throw "ENOENT, no such file or directory 'not/existing'"

    it 'should not throw if the script does not contain a request block', (done) ->

      construct = -> Script.load 'fixtures/script01.coffee', settings, () -> done()
      construct.should.not.throw()

    it 'should throw if the script does not contain any assert blocks', (done) ->

      construct = -> Script.load 'fixtures/script02.coffee', settings, () -> done()
      construct.should.not.throw()

    it 'should accept valid scripts', (done) ->

      construct = -> Script.load 'fixtures/script101.coffee', settings, () -> done()
      construct.should.not.throw()