
http = require 'http'

class Request

  constructor: () ->

    @data = ''
    @listeners = []

  transfer: (req) =>

    request = http.request req, (res) =>

      res.setEncoding 'utf8'
      res.on 'data', (chunk) => @data += chunk
      res.on 'end', () => @listeners.map (listener) => listener null, req, res, @data
      res.on 'error', (e) => @listeners.map (listener) -> listener e, req, res, null
      res.on 'close', (e) => @listeners.map (listener) -> listener e, req, res, null

    request.end()

  listener: (callback) => @listeners.push callback

module.exports = Request