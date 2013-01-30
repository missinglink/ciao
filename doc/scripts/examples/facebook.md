# Facebook graph API call

*Generated: Wed Jan 30 2013 23:28:03 GMT+0000 (GMT)*
## Request
```javascript
{
  "protocol": "https:",
  "host": "graph.facebook.com",
  "method": "GET",
  "port": 443,
  "path": "/peter.johnson.nz",
  "headers": {
    "User-Agent": "Ciao/Client 1.0"
  },
  "defaultPort": 443
}
```

## Response
```javascript
Status: 200
{
  "access-control-allow-origin": "*",
  "cache-control": "private, no-cache, no-store, must-revalidate",
  "content-type": "text/javascript; charset=UTF-8",
  "etag": "\"91ea1a920540ba8ca97c155f65cf0d21a12e659a\"",
  "expires": "Sat, 01 Jan 2000 00:00:00 GMT",
  "pragma": "no-cache",
  "x-fb-rev": "724288",
  "x-fb-debug": "aiwAqgp9juR3cs3y6MJKoWT4D+XnyK7NZZ2GzMxY6aU=",
  "date": "Wed, 30 Jan 2013 23:27:59 GMT",
  "connection": "close",
  "content-length": "148"
}
```
```javascript
{
  "id": "1617360746",
  "name": "Peter Johnson",
  "first_name": "Peter",
  "last_name": "Johnson",
  "username": "peter.johnson.nz",
  "gender": "male",
  "locale": "en_GB"
}
```

## Tests

### ✓ Resource is available
```javascript
response.statusCode.should.equal 200
```

### ✓ Should be a graph user object
```javascript
json.should.eql {
  id: "1617360746",
  name: "Peter Johnson",
  first_name: "Peter",
  last_name: "Johnson",
  username: "peter.johnson.nz",
  gender: "male",
  locale: "en_GB"
}
```

