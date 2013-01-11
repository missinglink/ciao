
fs = require 'fs'
CoffeeScript = require 'coffee-script'

# request = require 'request'

http = require 'http'

reqFiles = [ './test/01.coffee', './test/02.coffee' ]

# vm = require 'vm'

# files = [
#   './test/01-request.coffee'
#   # './test/01-code.coffee',
#   # './test/01-text.coffee'
# ]

# coffee = ''

parse = (lines) ->

  groups = []
  group = 
    title: 'head'
    source: ''

  lines.map (line) ->

    comment = line.match /^# (.*)$/

    if comment?[1]

      groups.push group
      group =
        title: comment[1]
        source: ''

    else group.source += ( line + "\n" )

  groups.push group
  return groups


child_process = require 'child_process'

# files.map (filename) ->

for reqFile in reqFiles

  if fs.statSync reqFile

    try
      lines = fs.readFileSync( reqFile ).toString('utf8').split('\n')

      groups = parse lines
      unless groups[1] then throw new Error 'Ciao: Could not find request section, did you add a title comment?'
      
      req = CoffeeScript.eval groups[1].source

      unless req?.path and req?.method then throw new Error 'Ciao: Invalid request section, you must specify at least path & method'
      unless groups[2] then throw new Error 'Ciao: No test sections found'




      callback = (error, response, body) ->

        throw new Error error if error

        env = process.env
        env['NODE_PATH'] = process.cwd() + "/node_modules"

        for test in groups[2...]

          script = "title = '" + test.title + "'\n" #"mocha = require 'mocha'" + "\n"
          script += "`response = { 'body': " + JSON.stringify(body) + ", 'statusCode': " + JSON.stringify(response.statusCode) + ", 'headers': " + JSON.stringify(response.headers) + " }`" + "\n"
          script += "\n"
          script += "try" + "\n"
          script += "  " + test.source + "\n"
          script += "catch e" + "\n"
          script += "  console.log title + ' failed with message: ' + e.message" + "\n"
          script += "  process.exit 1" + "\n"
          script += "process.exit 0" + "\n"
          script += "\n"

          # console.log script

          child = child_process.spawn 'coffee', [ '-s', '-r', 'should' ], env: env
          child.stdout.pipe process.stdout
          child.stderr.pipe process.stdout

          child.stdin.setEncoding 'utf-8'
          child.stdin.write script
          child.stdin.end()




      req = http.request req, (res) ->

        data = ''
        res.setEncoding 'utf8'
        res.on 'data', (chunk) -> data += chunk
        res.on 'end', () -> callback null, res, data
        res.on 'error', (e) -> callback e, res, null
        res.on 'close', (e) -> callback e, res, null

      req.end()

        
      # console.log groups

        #   console.log stdout
        #   console.log stderr

        #   if error?
        #     console.log error.stack
        #     console.log error.code
        #     console.log error.signal

        # coffee.on 'exit', (code) ->

        #   console.log 'exit', code

        # console.log 'responded!'
        # r = CoffeeScript.eval groups[2].source
        # console.log r



    #     context = new vm.Script.createContext
    #       response:
    #         code: 200
    #         body: 'Hello'
    #       source: CoffeeScript.compile groups[2].source
    #       should: require 'should'
    #       setup: "Object.defineProperty(Object.prototype, 'should', {
    #   set: function(){},
    #   get: function(){
    #     return new should.Assertion(Object(this).valueOf());
    #   },
    #   configurable: true
    # });"
    #       capture: "process.stdout.write = function(str){ output += str; }" 
    #       output: ''

    #     console.log vm.runInContext "eval(capture); eval(setup); eval(source); return output;", context

        # console.log CoffeeScript.eval "foo()", { sandbox: context }


      

      # context = new vm.createContext
      #   response:
      #     code: 200
      #     body: 'Hello'

      # console.log Object.keys context

      # vm.runInContext "should = require( 'should' );", context
      # vm.runInContext 'response.code.should.equal = function() {};', context

      # file = "should = require 'should'\n" + file


    #   request = CoffeeScript.eval file, { sandbox: context }
    catch e
      throw e

    # file = ( "\n" + file ).replace /\n/g, "\n  "
    # file = 'module.exports = \n' + file

    # try
    # compiled = CoffeeScript.compile file
    # console.log JSON.stringify compiled

    # console.log CoffeeScript.eval file
    # catch e
      # throw new Error 'Bad Coffee'
    

    # coffee += file

  # console.log coffee