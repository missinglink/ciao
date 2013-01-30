RequestChain = require 'lib/RequestChain'
should = require 'should'
fs = require 'fs'

describe 'RequestChain', ->

  describe 'constructor', ->

    it 'should not require a settings property', ->

      (->
        chain = new RequestChain()
        chain.settings.should.eql {}
      ).should.not.throw()

    it 'should set default properties', ->

      settings = bingo: 'bango'
      chain = new RequestChain settings
      chain.settings.should.equal settings
      chain.chain.should.eql []
      chain.env['NODE_PATH'].should.equal process.cwd() + '/node_modules'

  describe 'class interface', ->

    it 'should have better tests for these', ->

      chain = new RequestChain()
      chain.merge.should.be.instanceof Function
      chain.mergeScriptEval.should.be.instanceof Function
      chain.mergeScriptProcess.should.be.instanceof Function
      chain.run.should.be.instanceof Function
      chain.done.should.be.instanceof Function