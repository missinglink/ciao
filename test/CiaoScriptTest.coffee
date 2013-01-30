CiaoScript = require 'lib/CiaoScript'
should = require 'should'
fs = require 'fs'
Settings = require 'lib/Settings'

describe 'CiaoScript', ->

  describe 'constructor', ->

    settings = new Settings();

    it 'should throw unless settings are provided', ->

      construct = -> CiaoScript.load ''
      construct.should.throw "Invalid settings"

    it 'should throw on invalid file', ->

      construct = -> CiaoScript.load 'not/existing', settings
      construct.should.throw "ENOENT, no such file or directory 'not/existing'"

    it 'should throw if the script does not contain a request block', ->

      construct = -> CiaoScript.load 'fixtures/script01.coffee', settings
      construct.should.throw "FATAL: You must define a request section"

    it 'should throw if the script does not contain any assert blocks', ->

      construct = -> CiaoScript.load 'fixtures/script02.coffee', settings
      construct.should.throw "FATAL: No assert blocks found"

    it 'should accept valid scripts', (done) ->

      construct = -> CiaoScript.load 'fixtures/script101.coffee', settings, done
      construct.should.not.throw()