
ciao = require 'ciao'
should = require 'should'

authentication = require '../auth/login'

ciao.request ->

  uri: '/'
  method: 'GET'

ciao.use authentication

ciao.assert (response) ->

  response.code.should.equal 200
  response.body.should.include "I'm feeling lucky!"

ciao.assert (response) ->

  response.code.should.not.equal 304



# ciao = require 'ciao'
# should = require 'should'

# ciao.request '/'
# ciao.assert (response) -> response.code.should.be.below 400