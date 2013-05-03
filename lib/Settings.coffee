
deepmerge = require 'deepmerge'
fs = require 'fs'

class Settings

  constructor: () ->

    @config = {}
    @defaults =
      protocol: 'http:'
      host: "www.example.com"
      method: 'GET'
      port: 80
      path: '/'

  loadFromFile: (filename,silent=false) =>

    try
      throw new Error 'Failed to stat config file' unless fs.statSync filename
      json = JSON.parse fs.readFileSync filename
      return @merge json
    catch e
      unless silent
        console.log "\n \x1b[1;33m⚠\x1b[1;33m  WARNING: Failed to load #{filename}\x1b[0m"

    return @

  requireFile: (filename,silent=false) =>

    try
      json = require filename
      return @merge json
    catch e
      unless silent
        console.log "\n \x1b[1;33m⚠\x1b[1;33m  WARNING: Failed to load #{filename}\x1b[0m"

    return @

  merge: (settings) =>

    if settings?.defaults then @defaults = deepmerge @defaults, settings.defaults
    if settings?.config then @config = deepmerge @config, settings.config

    return @

module.exports = Settings