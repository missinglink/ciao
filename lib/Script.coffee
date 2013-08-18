fs = require 'fs'
ScriptParser = require './ScriptParser'
Settings = require './Settings'
RequestChain = require './RequestChain'

module.exports.mergeSettings = ( filename, settings, parser, callback ) ->

  chain = new RequestChain( settings )
  parser.sections.auth.map ( section ) -> chain.mergeScriptProcess section.source
  chain.mergeScriptProcess parser.sections.request[0].source

  chain.done = ( err, settings ) =>

    return callback( err ) if err

    unless settings.defaults?.host
      return callback( 'FATAL: Invalid request section, you must specify a host' )

    unless settings.defaults?.method
      return callback( 'FATAL: Invalid request section, you must specify a a method' )

    unless settings.defaults?.path
      return callback( 'FATAL: Invalid request section, you must specify a path' )

    callback null, settings, parser, filename

  chain.run()

module.exports.load = ( filename, settings, callback ) ->

  return callback( 'Invalid settings' ) unless settings and settings instanceof Settings

  try
    return callback( 'Failed to stat file' ) unless fs.statSync filename
    parser = new ScriptParser fs.readFileSync(filename), filename
  catch e
    return callback e.message

  if parser.sections.request.length < 1
    console.error " \x1b[1;33m⚠\x1b[1;33m  WARNING: Skipping file, no request section found in: #{filename}\x1b[0m"
    return callback null, settings, parser

  if parser.sections.request.length > 1
    console.error " \x1b[1;33m⚠\x1b[1;33m  WARNING: You may only have one request section per script in: #{filename}\x1b[0m"

  unless parser.sections.assert[0]
    console.error " \x1b[1;33m⚠\x1b[1;33m  WARNING: Skipping file, no assert blocks found in: #{filename}\x1b[0m"
    return callback null, settings, parser

  return module.exports.mergeSettings filename, settings, parser, callback