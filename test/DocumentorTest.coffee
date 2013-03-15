Documentor = require 'lib/Documentor'
EventEmitter = require('events').EventEmitter
should = require 'should'
fs = require 'fs'

describe 'Documentor', ->

  describe 'invalid constructor', ->

    it 'should throw an error if invalid runner provided', ->

      (-> documentor = new Documentor null ).should.throw 'Invalid runner'

  describe 'constructor', ->

    runner = new EventEmitter()
    documentor = new Documentor runner, 'bingo', '/tmp/bingo/bango.bongo'

    it 'should set default properties', ->

      documentor.runner.should.equal runner
      documentor.title.should.equal 'bingo'

    it 'should create file and directories recursively', ->

      stat = fs.statSync '/tmp/bingo/bango.bongo'
      stat.isFile().should.equal true

  describe 'documentTest', ->

    it 'should document a pass test', (done) ->

      test =
        source: 'console.log "bango.bongo"'
        title: 'Bingo Bongle'

      runner = new EventEmitter()
      documentor = new Documentor runner, 'bingo', '/tmp/bingo/bango.bongo'
      documentor.destination =
        write: (doc) ->
          doc.should.eql "### ✓ #{test.title}\n```javascript\n#{test.source}\n```\n\n"
          done()

      runner.emit 'complete', 0, 'stdout', 'stderr', test: test

    it 'should document a fail test', (done) ->

      test =
        source: 'console.error "A bingo error occurred"'
        title: 'Bingo Bongoo'

      runner = new EventEmitter()
      documentor = new Documentor runner, 'bingo', '/tmp/bingo/bango.bongo'
      documentor.destination =
        write: (doc) ->
          doc.should.eql "### ✘ #{test.title}\n```javascript\n#{test.source}\n```\nstdout\n\n"
          done()

      runner.emit 'complete', 1, 'stdout', 'stderr', test: test
