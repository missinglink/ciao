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

## Interpreter directives

Ciao currently supports 3 interpreter directives:

`#!` defines a `before` block, this is merged in to every `request` block

`#>` defines a `request` block, this is the main http(s) query definition block

`#?` defines an `assertion` block, this defines a test case which the `result` should conform to

Each directive is followed by a single space and a directive title

eg. `#> Contact page is available` defines a request with the title 'Contact page is available'

The title is used for reporting & documentation, so the better your titles, the easier life will be for you.

## Installing ciao

```bash
npm install ciao --save
```

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
