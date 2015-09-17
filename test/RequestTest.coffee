Request      = require 'lib/Request'
EventEmitter = require('events').EventEmitter

http = require 'http'
https = require 'https'

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
    client.on = ( key, cb ) -> null
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
    client.on = ( key, cb ) -> null
    client.res =
      setEncoding: ( enc ) -> enc.should.equal 'utf8'
      on: ( key, cb ) -> events[key] = cb

    client.write = ( body ) -> body.should.eql 'bingo%5Bbango%5D=bongo&ping=pong'
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

    describe 'constructor', ->

      it 'should set request data', ->

        request = new Request()
        request.data = {}

        request = new Request( 'foo' )
        request.data = 'foo'

    describe 'transfer', ->

      it 'should default to the http client', (done) ->

        request = new Request()
        request.request = (client, req) ->
          client.should.eql http
          req.model.should.equal 'req'
          done()

        request.transfer { model: 'req' }

      it 'should auto detect the https client from port', (done) ->

        request = new Request()
        request.request = (client, req) ->
          client.should.eql https
          req.model.should.equal 'req'
          done()

        request.transfer { model: 'req', port: 443 }

      it 'should auto detect the https client from protocol', (done) ->

        request = new Request()
        request.request = (client, req) ->
          client.should.eql https
          req.model.should.equal 'req'
          done()

        request.transfer { model: 'req', protocol: 'https:' }

      it 'should auto detect the https client from protocol without colon', (done) ->

        request = new Request()
        request.request = (client, req) ->
          client.should.eql https
          req.model.should.equal 'req'
          done()

        request.transfer { model: 'req', protocol: 'https' }

      it 'should auto add colon to protocol if missing', (done) ->

        request = new Request()
        request.request = (client, req) ->
          client.should.eql https
          req.model.should.equal 'req'
          done()

        request.transfer { model: 'req', protocol: 'https' }

      it 'should force agent to false', (done) ->

        request = new Request()
        request.request = (client, req) ->
          req.agent.should.equal false
          req.model.should.equal 'req'
          done()

        request.transfer { model: 'req' }

      it 'should allow injecting a custom agent', (done) ->

        request = new Request()
        request.request = (client, req) ->
          req.agent.should.equal false
          req.model.should.equal 'req'
          client.model.should.equal 'agent'
          done()

        request.transfer { model: 'req' }, { model: 'agent' }

      it 'should disable agent', ->

        request = new Request()
        request.data = {}

        request = new Request( 'foo' )
        request.data = 'foo'

    it 'should have a better test for this', ->

      request = new Request()
      request.request.length.should.eql 2