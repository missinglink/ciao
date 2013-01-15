fs = require 'fs'
fse = require 'fs-extra'
path = require 'path'

class Documentor

  constructor: (title,destination) ->

    @title = title
    fse.mkdirs path.dirname( destination ), (err) ->
      if err? then console.log 'Failed to create documentation at: ' + destination
    @destination = fs.createWriteStream destination

  documentTransaction: (error,req,res,body) =>

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

    if res.headers?['content-type']? and res.headers['content-type'] is 'application/json'
      contentType = 'javascript'
      body = JSON.stringify(JSON.parse(body),null,2)

    doc += "```#{contentType}\n" + body + "\n```\n\n"
    doc += "## Tests" + "\n\n"

    @destination.on 'error', (error) -> console.log error.message
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