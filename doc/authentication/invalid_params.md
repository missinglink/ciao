# Token Auth - Invalid Params

*Generated: Wed Jan 16 2013 12:45:23 GMT+0000 (GMT)*
## Request
```javascript
{
  "host": "stage.bizzby.me",
  "path": "/auth/token",
  "method": "POST",
  "headers": {
    "Accept": "application/json"
  }
}
```

## Response
```javascript
Status: 400
{
  "x-powered-by": "Express",
  "content-type": "application/json",
  "content-length": "81",
  "set-cookie": [
    "connect.sid=s%3AdxsQ1X4ytpLPXTegyVsV3qEG.tvE9605ARqkmvbw%2BfK16X3%2FlXWUJ3skYNU2e%2Fh3x0FA; Path=/"
  ],
  "date": "Wed, 16 Jan 2013 12:45:51 GMT",
  "connection": "keep-alive"
}
```
```javascript
{
  "meta": {},
  "body": {
    "error": "You must provide both 'service' and 'token' params"
  }
}
```

## Tests

### ✓ Status: 400 Bad Request
```javascript
response.statusCode.should.equal 400
```

### ✓ Error message is provided
```javascript
json = JSON.parse( response.body )
json.body.error.should.eql "You must provide both 'service' and 'token' params"
```

### ✓ Should set a cookie
```javascript
response.should.have.header 'Set-Cookie'
```

