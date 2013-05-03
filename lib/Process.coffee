
cp = require 'child_process'
EventEmitter = require('events').EventEmitter
winston = require 'winston'

class Process extends EventEmitter

  constructor: (@command,@args=null,@options=null,@data=null) ->

    @setup()

  setup: () =>

    @stdout = ''
    @stderr = ''
    @proc = cp.spawn @command, @args, @options

    # Provides backwards compatibility between 0.10 and 0.8
    @proc.on 'error', (error) -> @emit 'exit', 127, @stdout, error, @data

    @proc.stdin.setEncoding 'utf-8'
    @proc.stdout.setEncoding 'utf-8'
    @proc.stderr.setEncoding 'utf-8'

    @proc.stderr.on 'data', (data) =>
      if /^execvp\(\)/.test data then winston.error 'Failed to start child process'

    @proc.stdout.on 'data', (data) => @stdout += data
    @proc.stderr.on 'data', (data) => @stderr += data
    
    @proc.on 'exit', (code) =>
      # Put a 10ms delay on to give the std buffers time to write all their data out
      setTimeout ( () => @emit 'exit', code, @stdout, @stderr, @data ), 10

    @on 'write', (data) =>
      @proc.stdin.write data
      @proc.stdin.end()

    @proc.stdin.on 'error', (e) -> null
    @proc.stdout.on 'error', (e) -> null
    @proc.stderr.on 'error', (e) -> null

module.exports = Process