
#
# Coffee-Trace: Simpler and better way to match corresponding javascript 
# line when debuging CoffeeScript.
#
# just require this in your code and be happy...
#

Trace = require './lib/Trace'

views =
  source: require './view/source'
  help: require './view/help'
  hero: require './view/hero'
  stacktrace: require './view/stacktrace'
  newline: -> console.log()

module.exports = breakdown = (err) ->

  trace = new Trace err
  if trace

    views.newline()
    views.hero()
    views.newline()
    views.stacktrace trace
    views.newline()

    totalLines = 2
    hadCoffee = false

    for ord, line of trace.stack.lines[0..(totalLines-1)]

      if line.file
        views.source line, title: ( if Number(ord) is 0 then 'Thrown' else 'Previous' ), margin: 2
        views.newline()
        hadCoffee = true

    if not hadCoffee
      for line in trace.stack.lines[totalLines..]
        if /\.coffee$/.test line.filename
          if line.file
            views.source line, title: 'CoffeeScript', margin: 2
            views.newline()
            break

    views.help trace

  else console.error err.stack

process.on 'uncaughtException', breakdown