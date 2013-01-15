# Token Auth - Invalid Params

*Generated: Tue Jan 15 2013 10:52:18 GMT+0000 (GMT)*
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
    "connect.sid=s%3A8pp96A1d2gRKk27yaFbb86xT.y%2F4JWcvkSFMz6Fw1EDgSXVbnRK%2BQR18xMgISU82az00; Path=/"
  ],
  "date": "Tue, 15 Jan 2013 10:52:44 GMT",
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

### ✓ Should set a cookie
```javascript
response.should.have.header 'Set-Cookie'
```

### ✓ Error message is provided
```javascript
json = JSON.parse( response.body )
json.body.error.should.eql "You must provide both 'service' and 'token' params"
```

### ✓ Status: 400 Bad Request
```javascript
response.statusCode.should.equal 400
```

