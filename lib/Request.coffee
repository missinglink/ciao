
http = require 'http'
https = require 'https'

class Request

  constructor: () ->

    @data = ''
    @listeners = []

  transfer: (req) =>

    protocol = http
    if req.port is 443 then protocol = https

    request = protocol.request req, (res) =>

      res.setEncoding 'utf8'
      res.on 'data', (chunk) => @data += chunk
      res.on 'end', () => @listeners.map (listener) => listener null, req, res, @data
      res.on 'error', (e) => @listeners.map (listener) -> listener e, req, res, null
      res.on 'close', (e) => @listeners.map (listener) -> listener e, req, res, null

    if req.body?

      if 'string' is typeof req.body 
        request.write "#{req.body}\n"

      else if 'object' is typeof req.body
        foo = JSON.stringify req.body
        request.write "#{foo}\n"

    request.end()

  listener: (callback) => @listeners.push callback

module.exports = Request