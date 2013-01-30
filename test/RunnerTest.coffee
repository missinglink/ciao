Runner = require 'lib/Runner'
should = require 'should'
fs = require 'fs'

describe 'Runner', ->

  groups = []

  describe 'constructor', ->

    it 'should set default properties', ->

      runner = new Runner groups
      runner.groups.should.equal groups
      runner.listeners.should.eql []
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

      counter = 0
      listener = (code, stdout, stderr, data) ->
        data.test.should.eql groupData[counter]
        data.request.should.equal request
        code.should.eql counter
        if counter is 0 then stdout.should.eql ''
        if counter is 1
          stderr.should.eql "expected 'Bingo Bango Bongo!' to equal 'Bango-Bongo-Bingo!'\n"
          done()
        counter++

      runner = new Runner groupData
      runner.listener listener
      runner.complete null, request, { statusCode: 200, headers: {} }, "Bingo Bango Bongo!"

  describe 'indentSource', ->

    input = "hello\nworld\n  how\n  are\n  you"
    actual = Runner.indentSource input, '-', 2

    it 'should indent correctly', ->

      actual.should.eql "--hello\n--world\n--  how\n--  are\n--  you"
