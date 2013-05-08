Settings = require 'lib/Settings'

should = require 'should'
fs     = require 'fs'

describe 'Settings', ->

  describe 'constructor', ->

    it 'should not require any params', ->

      (-> new Settings() ).should.not.throw()

    it 'should set default params', ->

      settings = new Settings()
      settings.config.should.eql {}
      settings.defaults.should.eql
        protocol: 'http:'
        host: "www.example.com"
        method: 'GET'
        port: 80
        path: '/'

  describe 'loadFromFile', ->

    it 'should not error on invalid param', ->

      settings = new Settings()
      (-> settings.loadFromFile null ).should.not.throw()

    it 'should not error on file not found', ->

      settings = new Settings( '/tmp/invalid_file_name.json' )
      (-> settings.loadFromFile null ).should.not.throw()

    it 'should successfully load and merge config file', ->

      settings = new Settings()
      settings.defaults = {}

      ret = settings.requireFile 'ciao'
      ret.should.equal settings

      settings.config.should.eql { hello: 'world' }
      settings.defaults.should.include { port: 80 }

  describe 'merge', ->

    it 'should not error on invalid param', ->

      settings = new Settings()
      (-> settings.merge null ).should.not.throw()

    it 'should merge 2 sets of params', ->

      settings = new Settings()
      settings.defaults = {}

      ret = settings.merge
        config: foo: 'bar'
        defaults: bar: 'baz'

      ret.should.equal settings
      settings.config.should.eql { foo: 'bar' }
      settings.defaults.should.eql { bar: 'baz' }

      ret = settings.merge
        config: foo: 'moo'
        defaults: bingo: 'bango'

      ret.should.equal settings
      settings.config.should.eql { foo: 'moo' }
      settings.defaults.should.eql { bingo: 'bango', bar: 'baz' }
