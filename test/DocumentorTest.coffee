Documentor = require 'lib/Documentor'
should = require 'should'
fs = require 'fs'

describe 'Documentor', ->

  describe 'constructor', ->

    process = new Documentor 'bingo', '/tmp/bingo/bango.bongo'

    it 'should set default properties', ->

      process.title.should.equal 'bingo'

    it 'should create file and directories recursively', ->

      stat = fs.statSync '/tmp/bingo/bango.bongo'
      stat.isFile().should.equal true

  describe 'documentTest', ->

    it 'should document a pass test', (done) ->

      test =
        source: 'console.log "bango.bongo"'
        title: 'Bingo Bongle'

      process = new Documentor 'bingo', '/tmp/bingo/bango.bongo'
      process.destination =
        write: (doc) ->
          doc.should.eql "### ✓ #{test.title}\n```javascript\n#{test.source}\n```\n\n"
          done()

      process.documentTest 0, 'stdout', 'stderr', test: test

    it 'should document a fail test', (done) ->

      test =
        source: 'console.error "A bingo error occurred"'
        title: 'Bingo Bongoo'

      process = new Documentor 'bingo', '/tmp/bingo/bango.bongo'
      process.destination =
        write: (doc) ->
          doc.should.eql "### ✘ #{test.title}\n```javascript\n#{test.source}\n```\nstdout\n\n"
          done()

      process.documentTest 1, 'stdout', 'stderr', test: test
