fs = require 'fs'

class ScriptParser

  constructor: (@filename) ->

    @lines = fs.readFileSync(@filename).toString('utf8').split('\n')

  parseGroups: =>

    groups = []
    group = 
      title: 'head'
      source: ''

    @lines.map (line) =>

      comment = line.match /^# (.*)$/

      if comment?[1]

        groups.push group
        group =
          file: @filename
          title: comment[1]
          source: ''

      else group.source += ( line + "\n" )

    groups.push group
    return groups

module.exports = ScriptParser