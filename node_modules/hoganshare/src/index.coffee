fs = require 'fs'
Hogan = require 'hogan.js'

class HoganShare

    constructor: (dir, ext = "html") ->
        @templates = []
        @clientWrap = Hogan.compile fs.readFileSync(__dirname + "/../views/templates.js.mustache", "utf8")
        @dir = dir
        @ext = ext
            
    getTemplates: ->
        @fetchTemplates @dir
        @map()

    map: ->
        if @templates.length isnt 0 then @templates[@templates.length - 1].last = true
        @clientWrap.render templates: @templates

    fetchTemplates: (dir) -> @fetchTemplate file, dir for file in @getDirFiles dir

    fetchTemplate: (file, dir) ->
        if @matchesExtension file
            path = dir + '/' + file
            id = path
                .replace(@dir, '')
                .substr(1)
                .replace ".#{@ext}", ''
            template = fs.readFileSync path, "utf8"
            template = Hogan.compile template, { asString: true } 
            @templates.push file: path, id: id, template: template
        else @fetchTemplates "#{dir}/#{file}"

    matchesExtension: (file) -> file.substr(file.length - 5) is ".#{@ext}"

    getDirFiles: (dir) -> fs.readdirSync dir

module.exports = HoganShare