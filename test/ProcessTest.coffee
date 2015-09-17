Process = require 'lib/Process'
should = require 'should'
fs = require 'fs'

describe 'Process', ->

  env = process.env
  env['NODE_PATH'] = process.cwd() + '/node_modules'

  it 'should stdout an echo statement', (done) ->

    process = new Process 'echo', [ "Bingo Bongo Bango!" ]
    process.on 'exit', ( code, stdout, stderr, data ) ->
      code.should.equal 0
      stdout.should.eql 'Bingo Bongo Bango!\n'
      done()

  it 'should stderr when executable not found', (done) ->

    process = new Process 'foobarbazwoo'
    process.on 'exit', ( code, stdout, stderr, data ) ->
      code.should.be.lessThan 0
      done()

  it 'should compile coffee-script', (done) ->

    process = new Process 'coffee', [ '-s' ], { env: env }
    process.on 'exit', ( code, stdout, stderr, data ) ->
      code.should.equal 0
      stdout.should.eql '{"bingo":"bango"}\n'
      done()
    process.emit 'write', 'console.log JSON.stringify bingo: \'bango\''

  it 'should stderr on badly formatted coffee-script', (done) ->

    process = new Process 'coffee', [ '-s' ], { env: env }
    process.on 'exit', ( code, stdout, stderr, data ) ->
      code.should.equal 1
      stderr.should.containEql 'ReferenceError: Invalid is not defined'
      done()
    process.emit 'write', 'Invalid;'