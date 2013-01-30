
class ScriptParser

  constructor: (@script='',@id='') ->

    section = title: '', source: '', id: @id

    @sections =
      junk: [ section ]
      auth: []
      request: []
      assert: []

    for line in @lines = @script.toString('utf8').split('\n')

      if title = line.match /^## (.*)$/
        @sections.junk.push section = title: title[1], source: '', id: @id

      else if title = line.match /^#\! (.*)$/
        @sections.auth.push section = title: title[1], source: '', id: @id

      else if title = line.match /^#> (.*)$/
        @sections.request.push section = title: title[1], source: '', id: @id

      else if title = line.match /^#\? (.*)$/
        @sections.assert.push section = title: title[1], source: '', id: @id

      else if line.replace /\s/, ''
        section.source += '\n' if section.source
        section.source += line

module.exports = ScriptParser