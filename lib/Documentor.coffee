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
    doc += "Generated: " + ( new Date() ) + "\n"
    doc += "## Request" + "\n"
    doc += "```\n"
    doc += JSON.stringify(req,null,2) + "\n"
    doc += "```\n\n"
    doc += "## Response" + "\n"
    doc += "```\n"

    if res.headers['content-type']? and res.headers['content-type'] is 'application/json'
      body = JSON.stringify(JSON.parse(body),null,2)

    doc += body + "\n"
    doc += "```\n\n"

    @destination.on 'error', (error) ->
      console.log error.message

    @destination.write doc

    # console.log req
    # console.log body

module.exports = Documentor