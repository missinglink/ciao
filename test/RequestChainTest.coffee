RequestChain = require 'lib/RequestChain'
Settings = require 'lib/Settings'
should = require 'should'
fs = require 'fs'

describe 'RequestChain', ->

  describe 'constructor', ->

    it 'should not require a settings property', ->

      (->
        chain = new RequestChain()
        chain.settings.should.be.instanceof Settings
      ).should.not.throw()

    it 'should set default properties', ->

      settings = new Settings bingo: 'bango'
      chain = new RequestChain settings
      chain.settings.should.equal settings
      chain.chain.should.eql []
      chain.env['NODE_PATH'].should.equal process.cwd() + '/node_modules'

    it 'should throw unless a valid settings object is supplied', ->

      (-> new RequestChain {}).should.throw 'Invalid Settings'

  describe 'class interface', ->

    it 'should have better tests for these', ->

      chain = new RequestChain()
      chain.merge.should.be.instanceof Function
      chain.mergeScriptEval.should.be.instanceof Function
      chain.mergeScriptProcess.should.be.instanceof Function
      chain.run.should.be.instanceof Function
      chain.done.should.be.instanceof Function

  describe 'mergeScriptProcess', ->

    it 'should merge valid json', (done) ->

      chain = new RequestChain()
      chain.mergeScriptProcess "host: 'www.example.com'"
      chain.done = (err,settings) ->
        settings.defaults.host.should.eql 'www.example.com'
        done()
      chain.run()

    it 'should error on invalid json', (done) ->

      chain = new RequestChain()
      chain.mergeScriptProcess "console.log 'test'"
      chain.done = (err,settings) ->
        err.should.eql 'Invalid request / before block'
        done()
      chain.run()