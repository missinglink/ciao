Suite = require 'lib/Suite'
should = require 'should'
fs = require 'fs'

describe 'Suite', ->

  describe 'functional tests', ->

    it 'should scan the img directory', (done) ->

      counter = 0
      suite = new Suite (path,sweet) ->
        [ 'img/cans.jpg', 'img/ciao.png' ].should.include path
        sweet.files.should.include path
        counter++
        sweet.files.length.should.eql counter
        done() if counter > 1
      suite.walk 'img'

    it 'throw on symlink or any other non file or directory', ->

      counter = 0
      suite = new Suite()
      (-> suite.walk '/dev/null' ).should.throw 'Not a file or a directory...'

  describe 'should recurse subdirectories', ->

    it 'walks', (done) ->

      counter = 0
      suite = new Suite (path,sweet) ->
        should.exist path
        sweet.files.should.include path
        counter++
        sweet.files.length.should.eql counter
        done() if counter > 9
      suite.walk 'scripts'