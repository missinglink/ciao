Reporter = require 'lib/Reporter'
EventEmitter = require('events').EventEmitter
should = require 'should'
fs = require 'fs'

describe 'Reporter', ->

  data =
    test:
      title: 'Bingo'
      id: 'Bongo'
    request:
      protocol: 'ftp'
      port: 21
      host: 'www.google.com'
      path: '/'
      method: 'GET'

  describe 'standard', ->

    it 'should report on successful jobs', ->

      report = ''
      logger = log: (log) -> report += log
      runner = new EventEmitter()
      reporter = new Reporter.standard
      reporter.watch runner
      runner.emit 'complete', 0, 'stdout', 'stderr', data, logger
      report.should.eql ' \u001b[1mGET \u001b[1;0mftp//www.google.com:21/\u001b[0m \u001b[2mBongo \u001b[0m \u001b[1;32m✓\u001b[0;32m Bingo\u001b[0m \u001b[0mstdout\u001b[0m \u001b[1;33mstderr\u001b[0m'

    it 'should report on failed jobs', ->

      report = ''
      logger = log: (log) -> report += log
      runner = new EventEmitter()
      reporter = new Reporter.standard
      reporter.watch runner
      runner.emit 'complete', 1, 'stdout', 'stderr', data, logger
      report.should.eql ' \u001b[1mGET \u001b[1;0mftp//www.google.com:21/\u001b[0m \u001b[2mBongo \u001b[0m \u001b[1;31m✘\u001b[1;31m Bingo\u001b[0m \u001b[0mstdout\u001b[0m \u001b[1;33mstderr\u001b[0m'

  describe 'reqRes', ->

    it 'should have a better test', ->

      Reporter.reqRes.should.be.instanceof Function

  describe 'debug', ->

    it 'should have a better test', ->

      Reporter.debug.should.be.instanceof Function

  describe 'request', ->

    it 'should have a better test', ->

      Reporter.request.should.be.instanceof Function