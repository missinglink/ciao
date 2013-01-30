fs = require 'fs'
walk = require 'walk'
path = require 'path'

class TestSuite

  constructor: (@settings, @done) ->
    @files = []
    @listeners = []

  # Get list of files recursively
  walk: (path) =>

    try
      stats = fs.statSync path
    catch e
      console.log e.message or e
      return null

    if stats.isDirectory()

      walker = walk.walk( path, { followLinks: false } )
      walker.on 'file', ( root, stat, next ) =>
        @files.push( root + '/' + stat.name )
        next()
      walker.on 'end', () => @done file, @ for file in @files

    else if stats.isFile()
      @files.push path
      @done path, @

  listener: (callback) => @listeners.push callback

module.exports = TestSuite