fs = require 'fs'
walk = require 'walk'
path = require 'path'

class Suite

  constructor: (@done) ->
    @files = []

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
        scriptpath = root + '/' + stat.name
        @files.push scriptpath
        @done scriptpath, @
        next()

    else if stats.isFile()
      @files.push path
      @done path, @

    else throw new Error 'Not a file or a directory...'

module.exports = Suite