Script = require 'lib/Script'
should = require 'should'
fs = require 'fs'
Settings = require 'lib/Settings'

describe 'Script', ->

  describe 'constructor', ->

    settings = new Settings();

    it 'should error unless settings are provided', (done) ->

      Script.load '', null, ( err ) ->
        err.should.eql "Invalid settings"
        done()

    it 'should error on invalid file', (done) ->

      Script.load 'not/existing', settings, ( err ) ->
        err.should.eql "ENOENT, no such file or directory 'not/existing'"
        done()

    it 'should not throw if the script does not contain a request block', (done) ->

      construct = -> Script.load 'fixtures/script01.coffee', settings, () -> done()
      construct.should.not.throw()

    it 'should throw if the script does not contain any assert blocks', (done) ->

      construct = -> Script.load 'fixtures/script02.coffee', settings, () -> done()
      construct.should.not.throw()

    it 'should accept valid scripts', (done) ->

      construct = -> Script.load 'fixtures/script101.coffee', settings, () -> done()
      construct.should.not.throw()