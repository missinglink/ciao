# Ciao

Ciao is a simple command line utility for testing http(s) requests and generating API documentation.

## Scripts:

Ciao scripts are written in coffee-script, however it's important to note that they are interpreted, not executed.

### Basic script:

```coffee-script
#> Check Google is still running
host: 'www.google.co.uk'

#? Should have company name
response.body.should.include 'Google'
```

### Advanced script:

```coffee-script
#! Requried Headers
headers: 'User-Agent': 'Ciao/Client 1.0'

#> Github API call for node.js README
port: 443
protocol: 'https:'
host: 'api.github.com'
path: '/repos/joyent/node/readme'
headers: 'Accept': 'application/json'

#? Readme is available on Github
response.statusCode.should.equal 200
response.should.have.header 'server', 'GitHub.com'

#? Should be what we are looking for...
json.sha.should.match /^[a-z0-9]{40}/
json.should.include
  type: 'file'
  path: 'README.md'
  url: 'https://api.github.com/repos/joyent/node/contents/README.md'
  html_url: 'https://github.com/joyent/node/blob/master/README.md'
  git_url: 'https://api.github.com/repos/joyent/node/git/blobs/' + json.sha
```
When you run a script, documentation is produced. eg:
https://github.com/missinglink/ciao/blob/master/doc/scripts/examples/github-api.md

## Interpreter directives

Ciao uses a special syntax to declare the start and end of code blocks.

Currently 4 interpreter directives are supported:

* `#! before` block, this is merged in to every `request` block.
* `#> request` block, this is the main http(s) query definition block.
* `#? assertion` block, this defines a test case which the `result` should conform to.
* `## junk` block, all code in this block will be ignored by the parser.

Each directive is followed by a single space and a directive title

eg. `#> Contact page is available` defines a `#> request` block with the title `Contact page is available`.

The title is used for reporting & documentation, so the better your titles, the easier life will be for you.

## Installing Ciao

To install the most stable `ciao` binary globally on your system via `npm` you can simply:

```bash
$ [sudo] npm install -g ciao
$ ciao --help
```

* Note: documentation (such as this README) may cover features not yet available via `npm`.
* Note: you will need `node` and `npm` installed first: http://nodejs.org/download/


## Running Scripts

```
peter@edgy:/var/www/ciao$ ciao --help

  Usage: ciao [options] <file ...>

  Options:
    -h, --help                 output usage information
    -V, --version              output the version number
    -g, --gist [id]            load script from github gist id
    -c, --conf [dir]           an additional config file to load after ciao.json
    -s, --silent               disable reporters
    -v, --verbose              report full requests and responses on error
    -d, --documentation [dir]  generate documentation in output dir
```

### Running a single script

```bash
$ ciao scripts/examples/basic.coffee 

 GET http://www.google.co.uk/ scripts/examples/basic.coffee 
 ✓ Status: 200 OK

 GET http://www.google.co.uk/ scripts/examples/basic.coffee 
 ✓ Response.body should contain company name
```

### Running all scripts in a directory

You can also use ciao on directories to recursively run all scripts.

```bash
$ ciao scripts/
```

### Running a gist as a script

You can run remote scripts from github by providing the gist suffix or url.

```bash
$ ciao --gist missinglink/4678610
$ ciao --gist https://gist.github.com/missinglink/4678610
```

Note: The way the gist flag behaves has changed since `0.1.7`, please upgrade if you have issues.

## API Documentation

Ciao generates documentation for each `#> request`, the resulting `response` and all `#? assertion` blocks.

The documentation is in `markdown` format and is available in the directory specified using the `-d` option when executing `ciao`

eg. To generate documentation in `./doc` for all scripts in `./scripts`:
```bash
$ ciao -d doc scripts
```

An example generated documentation file can be found here:
https://github.com/missinglink/ciao/blob/master/doc/scripts/examples/github-api.md

## Requests

The ciao request format is the same as that of the `node.js` native http client `http.request`.

All `#> request` blocks have access to an object named `config` which contains all the static configuration properties defined in the ciao config. (as discussed below)

### Request properties

* `host` A domain name or IP address of the server to issue the request to. Defaults to 'www.example.com'.
* `hostname` To support url.parse() hostname is preferred over host
* `port` Port of remote server. Defaults to 80.
* `method` A string specifying the HTTP request method. Defaults to 'GET'.
* `path` Request path. Defaults to '/'. Should include query string if any. E.G. '/index.html?page=12'
* `headers` An object containing request headers.
* `auth` Basic authentication i.e. 'user:password' to compute an Authorization header.
* `body` If body is an object then `JSON.stringify` will be run on it before sending.

Full `http.request` reference: http://nodejs.org/api/http.html#http_http_request_options_callback

### Examples

```coffee-script
#> Post data to a JSON web service
path: '/blog/article'
method: 'POST'
headers:
  'Accept': 'application/json'
  'Content-Type': 'application/json'
body: 
  title: 'My amazing blog post'
  body: '@todo'
```

```coffee-script
#> Get package details from the npm registry
host: 'registry.npmjs.org'
path: '/ciao/latest'
headers: 'Accept': 'application/json'

#? Should have preferGlobal set to true
json.preferGlobal.should.be.true
```

## Assertions

You can add assertions to your scripts by including `#? assertion` blocks.

Currently `#? assertion` blocks only provide the functionality of the `should` js framework, but I am looking at adding more assertion libraries in the future.

Each test case has access to three objects named `title`, `response` & `json`.

* `title` is simply the title specified in the interpreter directive (as discussed above)
* `response` contains 3 properties returned by `http.request`
  * `body` contains the body of the http(s) response.
  * `statusCode` contains the status code of the http(s) response.
  * `headers` contains an array of headers that were returned.
* `json` the result of parsing the response.body with `JSON.parse` (empty for invalid json).

### Examples

```coffee-script
#? Test the response code
response.statusCode.should.equal 200

#? Test a header is set
response.should.have.header 'server'

#? Test a header value
response.should.have.header 'server', 'apache'

#? Test body contains string
response.body.should.include 'Bingo Bango Bongo!'

#? Test body contains regex
response.body.should.match /^[a-z0-9]{40}/

#? Test json object contains properties
json.should.include {
  id: "10000000000000000000",
  name: "Bingo Bango Bongo!"
}

#? Check for a redirect
response.should.have.header 'location', 'http://www.example.com/'
```

`should.js` reference: https://github.com/visionmedia/should.js/

## Configuration

Ciao looks for a global configuration file called `ciao.json` in your current working directory.

Example `ciao.json`

```javascript
{
  "defaults": {
    "host": "www.google.co.uk",
    "port": 80,
    "headers": {
      "User-Agent": "Ciao/Client 1.0"
    }
  },
  "config": {
    "bingo": "bango"
  }
}
```

The `defaults` section is merged in to every request that is made, it's useful for specifying global request properties such as `host` and `port`.

The `config` section is useful for storing session tokens or any sort of data you would like available to `#! before` or `#> request` blocks.

## How it works

When parsing `script` & `config` files ciao launches child processes to excute the coffee-script source.
This isolates the main thread from malicious code and ensures the fastest execution of tests.

All the requests are launched asyncronously using `http.request`.

After a `response` comes back from the target server; all `#? assertion` blocks are fired asyncronously in a seperate child process.

## Known bugs

It's early stages yet; there are a bunch of issues reported here:
https://github.com/missinglink/ciao/issues

Please report everything as it comes up, no matter how small.

## Contributing

Ciao is still in beta, if you are lucky enough to have git access, you're best to use `bleeding edge`:

### Quick start

```bash
$ git clone git@github.com:missinglink/ciao.git ciao
$ cd ciao
$ npm install
$ npm test
$ ./bin/ciao scripts/examples
```

### I have push access, what can I push?

Since we're in beta, you can push anything as long as you successfully run the commands below before pushing.

Pretty please; provide unit tests and script fixtures in the `test` and `fixtures` directories.

### Running Unit Tests

The unit test suite is run using `mocha`

```bash
$ npm test
```

### Running Ciao test scripts

This will execute all tests in the `./scripts` directory and write documentation in the `./doc` directory.

```bash
$ npm run ciao
```

### Code review

If you would like a code review or to open a feature discussion, please fork and pull request against upstream master.

## Project goals

### Short term

* Stability
* Cool Functionality
* Ease of use

### Mid term

* Improved reporters
* Improved documentors
* Web interface

### Long term

* Scheduled builds
* Hosted CI solution