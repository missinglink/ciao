
http = require 'http'
https = require 'https'
qs = require 'qs'
EventEmitter = require('events').EventEmitter

class Request extends EventEmitter

  constructor: () ->

    @data = ''

  transfer: (req,client=http) =>

    if req.port is 443 or req.protocol is 'https:' then client = https
    req.agent = false # Disable agent to avoid socket errors

    @request client, req

  request: (client, req) ->

    request = client.request req, (res) =>

      res.setEncoding 'utf8'
      res.on 'data', (chunk) => @data += chunk
      res.on 'end',  ()   => @emit 'complete', null, req, res, @data
      res.on 'error', (e) => @emit 'complete', e, req, res, @data
      res.on 'close', (e) => @emit 'complete', e, req, res, @data

    if not req.body? and req.headers?['Content-Type'] is 'application/json'
      req.body = {}

    # This is required or http.request throws a socket hangup error
    if req.method is 'GET' then req.body = undefined

    if req.body?
      if 'string' is typeof req.body 
        request.write "#{req.body}"

      else if 'object' is typeof req.body
        if req.headers?['Content-Type'] is 'application/x-www-form-urlencoded'
          body = qs.stringify req.body
          request.write "#{body}"
        else
          json = JSON.stringify req.body
          request.write "#{json}"

    request.end()

module.exports = Request
