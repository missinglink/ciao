Process = require 'lib/Process'
should = require 'should'
fs = require 'fs'

describe 'Process', ->

  env = process.env
  env['NODE_PATH'] = process.cwd() + '/node_modules'

  it 'should stdout an echo statement', (done) ->

    myProcess = new Process 'echo', [ "Bingo Bongo Bango!" ]
    myProcess.on 'exit', ( code, stdout, stderr, data ) ->
      code.should.equal 0
      stdout.should.eql 'Bingo Bongo Bango!\n'
      done()

  it 'should stderr when executable not found', (done) ->

    myProcess = new Process 'foobarbazwoo'
    myProcess.on 'exit', ( code, stdout, stderr, data ) ->
      code.should.equal 127
      stderr.should.equal process.ENOENT
      done()

  it 'should compile coffee-script', (done) ->

    myProcess = new Process 'coffee', [ '-s' ], { env: env }
    myProcess.on 'exit', ( code, stdout, stderr, data ) ->
      code.should.equal 0
      stdout.should.eql '{"bingo":"bango"}\n'
      done()
    myProcess.emit 'write', 'console.log JSON.stringify bingo: \'bango\''

  it 'should stderr on badly formatted coffee-script', (done) ->

    myProcess = new Process 'coffee', [ '-s' ], { env: env }
    myProcess.on 'exit', ( code, stdout, stderr, data ) ->
      code.should.equal 1
      stderr.should.containEql 'ReferenceError: Invalid is not defined'
      done()
    myProcess.emit 'write', 'Invalid;'
