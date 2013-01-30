fs = require 'fs'
mkdirp = require 'mkdirp'
path = require 'path'

class Documentor

  constructor: (title,destination) ->

    @title = title
    mkdirp.sync path.dirname destination
    @destination = fs.createWriteStream destination
    @destination.on 'error', (error) -> console.log error.message

  documentTransaction: (error,req,res,body) =>

    # @TODO: Figure out a better way of removing cyclic references in req
    req.agent = undefined

    doc = '# ' + @title + "\n\n"
    doc += "*Generated: " + ( new Date() ) + "*\n"
    doc += "## Request" + "\n"
    doc += "```javascript\n"
    doc += JSON.stringify(req,null,2) + "\n"
    doc += "```\n\n"
    doc += "## Response" + "\n"
    doc += "```javascript\n"
    doc += 'Status: ' + res.statusCode + "\n"
    doc += JSON.stringify(res.headers,null,2) + "\n"
    doc += "```\n"

    contentType = 'html'

    if res.headers?['content-type']?

      parseContentType = res.headers['content-type'].split ';'
      if parseContentType[0] and parseContentType[0].match /^(text|application)\/(json|javascript)$/

        contentType = 'javascript'
        body = JSON.stringify(JSON.parse(body),null,2)

    doc += "```#{contentType}\n" + body + "\n```\n\n"
    doc += "## Tests" + "\n\n"

    @destination.write doc

  documentTest: (code,stdout,stderr,data) =>

    trimSource = data.test.source.replace /^\s+|\s+$/g, ''

    if code is 0

      doc = '### ✓ ' + data.test.title + "\n"
      doc += "```javascript\n#{trimSource}\n```" + "\n"

    else

      doc = '### ✘ ' + data.test.title + "\n"
      doc += "```javascript\n#{trimSource}\n```" + "\n"
      doc += stdout + "\n"

    doc += "\n"

    @destination.write doc

module.exports = Documentor