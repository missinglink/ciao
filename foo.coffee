
ciao = require 'ciao'
auth = require './suites/auth/login'

ciao.use auth

ciao.request ->

  uri: '/'
  method: 'GET'

ciao.assert (response) ->

  response.code.should.equal 200
  response.body.should.include "I'm feeling lucky!"

ciao.assert (response) ->

  response.code.should.not.equal 304


# ------------------


describe 'home page', ->

  it 'is online', (done) ->

    ciao.request '/', (response) ->

      response.status.should.equal 200
      response.body.should.include "I'm feeling lucky!"
      response.status.should.not.equal 304

      done()


# ------------------


describe 'account service', ->

  it 'lists users', (done) ->

    action = 
      method: 'POST'
      uri: 'http://www.google.com/login'
      form: 
        email: 'test@example.com'
        password: '1234567890'

    ciao.request action, (response) ->

      response.status.should.equal 200
      response.body.should.include "Logged In"
      response.header.should.have.keys ['cookie']

      done()