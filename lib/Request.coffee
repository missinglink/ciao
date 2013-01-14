
http = require 'http'

class Request

  constructor: () ->

    @data = ''

  transfer: (req,callback) =>

    request = http.request req, (res) =>

      res.setEncoding 'utf8'
      res.on 'data', (chunk) => @data += chunk
      res.on 'end', () => callback null, res, @data
      res.on 'error', (e) => callback e, res, null
      res.on 'close', (e) => callback e, res, null

    request.end()

module.exports = Request