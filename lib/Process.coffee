
cp = require 'child_process'
EventEmitter = require('events').EventEmitter

class Process extends EventEmitter

  constructor: (@command,@args=null,@options=null,@data=null) ->

    @setup()

  setup: () =>

    @stdout = ''
    @stderr = ''
    @proc = cp.spawn @command, @args, @options

    @proc.stdout.on 'data', (data) => @stdout += data
    @proc.stderr.on 'data', (data) => @stderr += data
    
    @proc.on 'exit', (code) =>
      # Put a 10ms delay on to give the std buffers time to write all their data out
      setTimeout ( () => @emit 'exit', code, @stdout, @stderr, @data ), 10

    @on 'write', (data) =>
      @proc.stdin.setEncoding 'utf-8'
      @proc.stdin.write data
      @proc.stdin.end()

module.exports = Process