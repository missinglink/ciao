Request = require 'lib/Request'
should = require 'should'
fs = require 'fs'

describe 'Request', ->

  describe 'constructor', ->

    request = new Request()

    it 'should set default properties', ->

      request.data.should.eql ''
      request.listeners.should.eql []

      request.request.should.be.instanceof Function
      request.transfer.should.be.instanceof Function
      request.listener.should.be.instanceof Function

  describe 'transfer', ->

    events = {}
    client = {}
    client.res =
      setEncoding: ( enc ) -> enc.should.equal 'utf8'
      on: ( key, cb ) -> events[key] = cb

    client.write = ( body ) -> body.should.eql '{\"bingo\":\"bango\"}\n'
    client.end = () -> null
    client.request = ( req, cb ) ->
      cb client.res
      return client

    listener = ( error, req, res, data ) ->
      should.not.exist error
      req.should.eql { host: 'www.bingo.com', body: { bingo: 'bango' }, agent: false }
      res.should.equal client.res
      data.should.equal 'bingobango'

    it 'functional test', ->

      request = new Request()
      request.listener listener
      request.transfer { host: 'www.bingo.com', body: bingo: 'bango' }, client

      events['data']( 'bingo' )
      events['data']( 'bango' )
      events['end']()

  describe 'request', ->

    it 'should have a better test for this', ->

      request = new Request()
      request.request.length.should.eql 2

  describe 'listener', ->

    it 'should add one listener', ->

      callback = () -> return null
      request = new Request()
      request.listener callback
      request.listeners.length.should.eql 1
      request.listeners.should.eql [ callback ]