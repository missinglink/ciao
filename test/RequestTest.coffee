Request      = require 'lib/Request'
EventEmitter = require('events').EventEmitter

should = require 'should'
fs     = require 'fs'

describe 'Request', ->

  describe 'constructor', ->

    request = new Request()

    it 'should set default properties', ->

      request.should.be.instanceof EventEmitter
      request.data.should.equal ''

      request.request.should.be.instanceof Function
      request.transfer.should.be.instanceof Function

  # TODO This test is shit, scrub it and start again
  describe 'transfer json', ->

    events = {}
    client = {}
    client.res =
      setEncoding: ( enc ) -> enc.should.equal 'utf8'
      on: ( key, cb ) -> events[key] = cb

    client.write = ( body ) -> body.should.eql '{\"bingo\":{\"bango\":\"bongo"}}'
    client.end = () -> null
    client.request = ( req, cb ) ->
      cb client.res
      return client

    it 'functional test', ->

      request = new Request()

      request.on 'complete', ( error, req, res, data ) ->
        should.not.exist error
        req.should.eql { host: 'www.bingo.com', body: { bingo: { bango: 'bongo' } }, agent: false }
        res.should.equal client.res
        data.should.equal 'bingobango'

      request.transfer { host: 'www.bingo.com', body: { bingo: { bango: 'bongo' } } }, client

      events['data']( 'bingo' )
      events['data']( 'bango' )
      events['end']()

  # This test is shit, scrub it and start again
  describe 'transfer form data', ->

    events = {}
    client = {}
    client.res =
      setEncoding: ( enc ) -> enc.should.equal 'utf8'
      on: ( key, cb ) -> events[key] = cb

    client.write = ( body ) -> body.should.eql 'bingo[bango]=bongo&ping=pong'
    client.end = () -> null
    client.request = ( req, cb ) ->
      cb client.res
      return client

    it 'functional test', ->

      request = new Request()

      request.on 'complete', ( error, req, res, data ) ->
        should.not.exist error
        req.should.eql {
          host: 'www.bingo.com',
          body: { bingo: { bango: 'bongo' }, ping: 'pong' },
          headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
          agent: false
        }
        res.should.equal client.res
        data.should.equal 'bingobango'

      request.transfer {
        host: 'www.bingo.com',
        body: { bingo: { bango: 'bongo' }, ping: 'pong' },
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' }
      }, client

      events['data']( 'bingo' )
      events['data']( 'bango' )
      events['end']()

  describe 'request', ->

    it 'should have a better test for this', ->

      request = new Request()
      request.request.length.should.eql 2