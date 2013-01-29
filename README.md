# Ciao - Functional testing made easy

Ciao is a simple framework for testing HTTP(s) requests and generating API documentation.

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

## Installing ciao

Ciao is still in beta, if you are lucky enough to have git access, you're best to use:

```bash
git clone git@github.com:missinglink/ciao.git node_modules/ciao
```

DO NOT DO THIS!: For the latest stable release (cough), you can install via `npm`:

```bash
npm install ciao --save
```

Note: documentation (such as this README) should only refer to `bleeding edge` and not `stable`.

## Setting up your project

There are many ways to configure ciao, but the bare basics are:

```javascript
path = require('path');
ciao = require('ciao');

runner = new ciao({
  "testDir": path.resolve( './scripts' ),
  "docDir": path.resolve( './doc' ),
  "defaults": {
    "host": 'www.google.co.uk',
    "port": 80
  },
  "config": {
    'tester@test.com': 'foo'
  }
});
```

This will set up ciao to read scripts from `./scripts` and write documentation to `./doc`

You can also configure default options to pass to every request in the `defaults` section and provide your tests with a global `config` section.

The `config` section is useful for storing session tokens or any sort of data you would like available to `before` or `request` blocks.

## Assertions

You can add assertions to your scripts by including `assertion` blocks.

Currently assertion blocks only provide the functionality of the `should` js framework, but I am looking at adding more assertion libraries in the future.

Each test case has access to two properties `title` & `response`.

`title` is simply the title specified in the interpreter directive (as discussed above)

`response` contains 3 properties:

`response.body` contains the body of the http(s) response.

`response.statusCode` contains the status code of the http(s) response.

`response.headers` contains an array of headers that were returned.

In all 3 cases, these properties are exactly the same as what you would get if you used `http.request`.

`should.js` reference: https://github.com/visionmedia/should.js/

## API Documentation

Ciao generates documentation for each `request`, it's `response` and all `assertion` blocks.

The documentation is in `markdown` format and is available in the directory specified in the ciao config (as discussed above).

## How it works

Under-the-hood Ciao fires off all requests asyncronously using `http.request`.

After a `response` comes back from the target server; all `assertion` blocks are fired asyncronously in a seperate child process.

This isolates the main thread from malicious assertion code and ensures the fastest execution of tests.

`http.request` reference: http://nodejs.org/api/http.html#http_http_request_options_callback

## Contributing

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

## Known bugs

It's early stages yet; there are a bunch of issues reported here:
https://github.com/missinglink/ciao/issues

Please report everything as it comes up, no matter how small.