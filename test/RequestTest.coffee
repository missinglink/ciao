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