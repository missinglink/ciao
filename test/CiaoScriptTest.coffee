CiaoScript = require 'lib/CiaoScript'
should = require 'should'
fs = require 'fs'
Settings = require 'lib/Settings'

describe 'CiaoScript', ->

  describe 'constructor', ->

    settings = new Settings();

    it 'should throw unless settings are provided', ->

      construct = -> new CiaoScript ''
      construct.should.throw "Invalid settings"

    it 'should throw on invalid file', ->

      construct = -> new CiaoScript 'not/existing', settings
      construct.should.throw "ENOENT, no such file or directory 'not/existing'"

    it 'should throw if the script is invalid', ->

      construct = -> new CiaoScript 'fixtures/script01.coffee', settings
      construct.should.throw "FATAL: You must define a request section"

    # it 'should throw unless settings are provided', ->

    #   (-> new CiaoScript 'fixtures/script101.coffee', {} ).should.throw "Invalid settings, you must provide "


    # it 'should accept valid scripts', ->

    #   parser = new CiaoScript 'fixtures/script101.coffee', settings

  #   it 'should create empty sections', ->

  #     parser.sections.junk.should.be.instanceOf Array
  #     parser.sections.auth.should.be.instanceOf Array
  #     parser.sections.request.should.be.instanceOf Array
  #     parser.sections.assert.should.be.instanceOf Array

  # describe 'script02', ->

  #   parser = new CiaoScript script02, 'script02'

  #   it 'should not require a leading newline', ->

  #     parser.sections.request[0].title.should.eql 'Test for no leading newline'
  #     parser.sections.request[0].source.should.eql parser.lines[1]