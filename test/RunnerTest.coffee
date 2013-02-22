Runner = require 'lib/Runner'
EventEmitter = require('events').EventEmitter
should = require 'should'
fs = require 'fs'

describe 'Runner', ->

  groups = []

  describe 'constructor', ->

    it 'should set default properties', ->

      runner = new Runner groups
      runner.should.be.instanceof EventEmitter
      runner.groups.should.equal groups
      runner.env['NODE_PATH'].should.equal process.cwd() + '/node_modules'

  describe 'complete', ->

    it 'should throw if given an error message', ->

      runner = new Runner groups
      (-> runner.complete 'Bingo Bango', null, null, null ).should.throw '[REQUEST ERROR] Bingo Bango'

    it 'should throw if given an error object', ->

      runner = new Runner groups
      (-> runner.complete new Error 'Bingo Bango', null, null, null ).should.throw '[REQUEST ERROR] Bingo Bango'
    

  describe 'functional tests', ->

    it 'should run some basic tests', (done) ->

      groupData = [
        {
          title: 'bingo',
          source: 'response.body.should.eql "Bingo Bango Bongo!"'
        },
        {
          title: 'bango',
          source: 'response.body.should.eql "Bango-Bongo-Bingo!"'
        }
      ]

      request = { bingo: 'bango' }
      runner = new Runner groupData

      counter = 0
      runner.on 'complete', (code, stdout, stderr, data) ->
        stdout.should.eql ''
        [ 0, 1 ].should.include code
        data.request.should.equal request
        [ 'bingo', 'bango' ].should.include data.test.title
        [ "expected 'Bingo Bango Bongo!' to equal 'Bango-Bongo-Bingo!'\n", '' ].should.include stderr
        done() if counter is 1 
        counter++

      runner.complete null, request, { statusCode: 200, headers: {} }, "Bingo Bango Bongo!"

  describe 'indentSource', ->

    input = "hello\nworld\n  how\n  are\n  you"
    actual = Runner.indentSource input, '-', 2

    it 'should indent correctly', ->

      actual.should.eql "--hello\n--world\n--  how\n--  are\n--  you"
0