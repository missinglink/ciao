
deepmerge = require 'deepmerge'
fs = require 'fs'

class Settings

  constructor: (settings={}, @filename='ciao.json') ->

    @config = {}
    @defaults =
      host: "localhost"
      port: 3000

    try
      throw new Error 'Failed to stat config file' unless fs.statSync @filename
      json = JSON.parse fs.readFileSync @filename
      @merge json
    catch e
      console.log "WARN: Failed to load config file"  

    @merge settings

  merge: (settings) ->

    if settings.defaults then @defaults = deepmerge @defaults, settings.defaults
    if settings.config then @config = deepmerge @config, settings.config

module.exports = Settings