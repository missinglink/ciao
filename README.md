# Ciao - Functional testing made easy

Ciao is a simple command line utility for testing HTTP(s) requests and generating API documentation.

## Anatomy of a ciao script:

Ciao scripts are written in coffee-script, however it's important to note that they are interpreted, not executed.

### Sample script:

```coffee-script
#! Requried Headers
headers: 'User-Agent': 'Ciao/Client 1.0'

#> Check the home page is up!
host: 'www.google.co.uk'
path: '/'
method: 'GET'

#? Status: 200 OK
response.statusCode.should.equal 200

#? Response.body should contain company name
response.body.should.include 'Google'
```
When you run a script, documentation is produced. eg:
https://github.com/missinglink/ciao/blob/master/example.md

## Interpreter directives

Ciao uses a special syntax to declare the start and end of code blocks.

The parser will include all code following the directive within that block.

Currently 4 interpreter directives are supported:

`#!` defines a `before` block, this is merged in to every `request` block.

`#>` defines a `request` block, this is the main http(s) query definition block.

`#?` defines an `assertion` block, this defines a test case which the `result` should conform to.

`##` defines a `junk` block, all code in this block will be ignored by the parser.

Each directive is followed by a single space and a directive title

eg. `#> Contact page is available` defines a `request` block with the title `Contact page is available`.

The title is used for reporting & documentation, so the better your titles, the easier life will be for you.

## Installing Ciao

Ciao is still in beta, if you are lucky enough to have git access, you're best to `bleeding edge`:

```bash
git clone git@github.com:missinglink/ciao.git ciao
cd ciao
npm install
PATH=bin/:$PATH
ciao --help
```

If you want to install the most stable `ciao` binary globally on your system via `npm` then use

```bash
npm install -g ciao
ciao --help
```

Note: documentation (such as this README) should only refer to `bleeding edge` and not `stable`.


## Running the command line interface

Note: Unless you installed ciao globally, you will need to manually add `bin/` to your path before executing `ciao` on the command line

```bash
PATH=bin/:$PATH
```

```bash
ciao scripts/static/README.example.coffee
```

![Ciao](https://github.com/missinglink/ciao/raw/master/img/ciao.png "Ciao")

You can also use ciao on directories to recursively run all scripts.

```bash
ciao scripts
```

## Configuration

Ciao looks for a global configuration file called `ciao.json` in your current working directory.

Example `ciao.json`

```javascript
{
  "settings": {
    "docDir": "./doc"
  },
  "defaults": {
    "host": "www.google.co.uk",
    "port": 80,
    "headers": {
      "User-Agent": "Ciao/Client 1.0"
    }
  }
}
```

The `docDir` property will set up ciao to write documentation to `./doc`

The `defaults` section is merged in to every request that is made, it's useful for specifying global request properties such as `host` and `port`.

The `config` section is useful for storing session tokens or any sort of data you would like available to `before` or `request` blocks.

## Requests

The Ciao request format is the same as that of the `node.js` native http client `http.request`.

The `body` property is sent as the request body. If the body is an object then Ciao uses JSON.stringify to convert it to a string before sending it.

All `request` blocks have access to an object named `config` which contains all the static configuration properties defined in the ciao config. (as discussed above)

`http.request` reference: http://nodejs.org/api/http.html#http_http_request_options_callback

### Examples

Posting data to a JSON web service

```coffee-script
path: '/blog/article'
method: 'POST'
headers:
  'Accept': 'application/json'
  'Content-Type': 'application/json'
body: 
  title: 'My amazing blog post'
  body: '@todo'
```

## Assertions

You can add assertions to your scripts by including `assertion` blocks.

Currently assertion blocks only provide the functionality of the `should` js framework, but I am looking at adding more assertion libraries in the future.

Each test case has access to two objects named `title` & `response`.

`title` is simply the title specified in the interpreter directive (as discussed above)

`response` contains 3 properties:

`response.body` contains the body of the http(s) response.

`response.statusCode` contains the status code of the http(s) response.

`response.headers` contains an array of headers that were returned.

In all 3 cases, these properties are exactly the same as what you would get if you used `http.request`.

`should.js` reference: https://github.com/visionmedia/should.js/

## API Documentation

Ciao generates documentation for each `request`, the resulting `response` and all `assertion` blocks.

The documentation is in `markdown` format and is available in the directory specified in the ciao config (as discussed above).

An example generated documentation file can be found here:
https://github.com/missinglink/ciao/blob/master/example.md

## How it works

Under-the-hood Ciao fires off all requests asyncronously using `http.request`.

After a `response` comes back from the target server; all `assertion` blocks are fired asyncronously in a seperate child process.

This isolates the main thread from malicious assertion code and ensures the fastest execution of tests.

`http.request` reference: http://nodejs.org/api/http.html#http_http_request_options_callback

## Known bugs

It's early stages yet; there are a bunch of issues reported here:
https://github.com/missinglink/ciao/issues

Please report everything as it comes up, no matter how small.

## Contributing

### Quick start

Clone the project, enter the project directory and run:

```bash
npm install
npm test
npm run ciao
```

### I have push access, what can I push?

Since we're in beta, you can push anything as long as you successfully run the commands below before pushing.

Pretty please; provide unit tests and script fixtures in the `test` and `fixtures` directories.

### Running Unit Tests

The unit test suite is run using `mocha`

```bash
npm test
```

### Running Ciao test scripts

This will execute all tests in the `./scripts` directory and write documentation in the `./doc` directory.

```bash
npm run ciao
```

### Code review

If you would like a code review or to open a feature discussion, please fork and pull request against upstream master.

## Project goals

### Short term

* Stability
* Cool Functionality
* Ease of use

### Mid term

* Command line utility
* Improved reporters
* Improved documentors
* Web interface

### Long term

* Scheduled builds
* Hosted CI solution