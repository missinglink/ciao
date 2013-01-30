
http = require 'http'
https = require 'https'

class Request

  constructor: () ->

    @data = ''
    @listeners = []

  transfer: (req,client=http) =>

    if req.port is 443 then client = https
    req.agent = false # Disable agent to avoid socket errors

    @request client, req

  request: (client, req) ->

    request = client.request req, (res) =>

      res.setEncoding 'utf8'
      res.on 'data', (chunk) => @data += chunk
      res.on 'end',  ()   => @listeners.map (listener) => listener null, req, res, @data
      res.on 'error', (e) => @listeners.map (listener) -> listener e, req, res, @data
      res.on 'close', (e) => @listeners.map (listener) -> listener e, req, res, @data

    if req.body?

      if 'string' is typeof req.body 
        request.write "#{req.body}\n"

      else if 'object' is typeof req.body
        json = JSON.stringify req.body
        request.write "#{json}\n"

    request.end()

  listener: (callback) => @listeners.push callback

module.exports = Request