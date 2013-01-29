
deepmerge = require 'deepmerge'
fs = require 'fs'

class Settings

  constructor: (@filename='ciao.json') ->

    @defaults =
      host: "localhost"
      port: 3000

    @config = {}
    @testDir = './scripts'
    @docDir = './doc'

    throw new Error 'Failed to stat config file' unless fs.statSync @filename
    json = JSON.parse fs.readFileSync @filename

    if json.defaults then @defaults = deepmerge @defaults, json.defaults
    if json.config then @config = deepmerge @config, json.config
    if json.testDir then @testDir = deepmerge @testDir, json.testDir
    if json.docDir then @docDir = deepmerge @docDir, json.docDir

module.exports = Settings