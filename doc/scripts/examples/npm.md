# Get package details from the npm registry

*Generated: Wed Jan 30 2013 21:35:07 GMT+0000 (GMT)*
## Request
```javascript
{
  "protocol": "http:",
  "host": "registry.npmjs.org",
  "method": "GET",
  "port": 80,
  "path": "/ciao/latest",
  "headers": {
    "User-Agent": "Ciao/Client 1.0",
    "Accept": "application/json"
  }
}
```

## Response
```javascript
Status: 200
{
  "vary": "Accept",
  "server": "CouchDB/1.2.1 (Erlang OTP/R15B)",
  "etag": "\"5E2HNX8HU62DALFY9KNOZ2DIM\"",
  "date": "Wed, 30 Jan 2013 21:33:20 GMT",
  "content-type": "application/json",
  "content-length": "1085"
}
```
```javascript
{
  "name": "ciao",
  "preferGlobal": true,
  "private": false,
  "version": "0.1.2",
  "description": "Ciao is a simple command line utility for testing http(s) requests and generating API documentation",
  "contributors": [],
  "dependencies": {
    "walk": "~2.2.1",
    "coffee-script": "~1.4.0",
    "mkdirp": "0.3.x",
    "underscore": "~1.4.3",
    "deepmerge": "~0.2.5",
    "should": "~1.2.1",
    "commander": "*",
    "q": "*",
    "async": "~0.1.22"
  },
  "bin": {
    "ciao": "./bin/ciao"
  },
  "scripts": {
    "test": "export NODE_PATH=`pwd` && node node_modules/mocha/bin/mocha --recursive --reporter spec --compilers coffee:coffee-script test",
    "ciao": "export NODE_PATH=`pwd` && rm -rf doc && mkdir doc && ./bin/ciao -d doc scripts"
  },
  "devDependencies": {
    "mocha": "*"
  },
  "readme": "Documentation: https://github.com/missinglink/ciao",
  "engines": {
    "node": "0.8.x",
    "npm": "1.1.x"
  },
  "repository": {
    "type": "git",
    "url": "https://github.com/missinglink/ciao.git"
  },
  "_id": "ciao@0.1.2",
  "dist": {
    "shasum": "fec23119b47298c7b9c7021d3004721fd9b3d7ac",
    "tarball": "http://registry.npmjs.org/ciao/-/ciao-0.1.2.tgz"
  },
  "maintainers": [
    {
      "name": "missinglink",
      "email": "peter@missinglink.co.nz"
    }
  ],
  "directories": {}
}
```

## Tests

### ✓ Should have preferGlobal set to true
```javascript
json.preferGlobal.should.be.true
```

