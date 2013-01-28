
path = require 'path'
ciao = require './index.js'

runner = new ciao
  testDir: path.resolve './scripts'
  docDir: path.resolve './doc'
  defaults:
    host: 'www.google.co.uk'
    port: 80
  config:
    'tester@test.com': 'foo'