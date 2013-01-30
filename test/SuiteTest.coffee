Suite = require 'lib/Suite'
should = require 'should'
fs = require 'fs'

describe 'Suite', ->

  it 'should pass a functional test', (done) ->

    suite = new Suite (path,sweet) ->
      sweet.should.equal suite
      path.should.eql 'ciao.json'
      suite.files.should.eql [ 'ciao.json' ]
      done()
    suite.walk 'ciao.json'

  describe 'should recurse directories', ->

    it 'walks', (done) ->

      counter = 0
      callback = (path,sweet) ->
        sweet.should.equal suite
        should.exist path
        counter++
        done() if counter > 5

      suite = new Suite callback
      suite.walk 'scripts'