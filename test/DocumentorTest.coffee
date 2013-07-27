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

    it 'should document a multiple pass tests', (done) ->

      counter = 0
      test1 =
        source: 'console.log "bango.bongo"'
        title: 'Bingo Bango'
      test2 =
        source: 'console.log "bango.bongo"'
        title: 'Bango Bongo'

      runner = new EventEmitter()
      documentor = new Documentor runner, 'bingo', '/tmp/bingo/bango.bongo'
      documentor.destination =

        write: (doc) ->
          if ++counter is 1
            doc.should.eql "### ✓ #{test1.title}\n```javascript\n#{test1.source}\n```\n\n"
          else
            doc.should.eql "### ✓ #{test2.title}\n```javascript\n#{test2.source}\n```\n\n"
            done()

      runner.emit 'complete', 0, 'stdout', 'stderr', test: test1
      runner.emit 'complete', 0, 'stdout', 'stderr', test: test2

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

    it 'should document a multiple fail tests', (done) ->

      counter = 0
      test1 =
        source: 'console.log "bango.bongo"'
        title: 'Bingo Bango'
      test2 =
        source: 'console.log "bango.bongo"'
        title: 'Bango Bongo'

      runner = new EventEmitter()
      documentor = new Documentor runner, 'bingo', '/tmp/bingo/bango.bongo'
      documentor.destination =

        write: (doc) ->
          if ++counter is 1
            doc.should.eql "### ✘ #{test1.title}\n```javascript\n#{test1.source}\n```\nstdout\n\n"
          else
            doc.should.eql "### ✘ #{test2.title}\n```javascript\n#{test2.source}\n```\nstdout\n\n"
            done()

      runner.emit 'complete', 1, 'stdout', 'stderr', test: test1
      runner.emit 'complete', 1, 'stdout', 'stderr', test: test2

    it 'should cover issue #46', (done) ->

      counter = 0
      test1 =
        source: "should.exist json.body"
        title: 'check 1'
      test2 =
        source: "json.body.user.mobile_number.should.equal '+447868493599'"
        title: 'check 2'

      runner = new EventEmitter()
      documentor = new Documentor runner, 'bingo', '/tmp/bingo/bango.bongo'
      documentor.destination =

        write: (doc) ->
          if ++counter is 1
            doc.should.eql "### ✓ #{test1.title}\n```javascript\n#{test1.source}\n```\n\n"
          else
            doc.should.eql "### ✘ #{test2.title}\n```javascript\n#{test2.source}\n```\nstdout\n\n"
            done()

      runner.emit 'complete', 0, 'stdout', 'stderr', test: test1
      runner.emit 'complete', 1, 'stdout', 'stderr', test: test2
