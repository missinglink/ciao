# Token Auth - Invalid Params

*Generated: Fri Jan 18 2013 16:07:33 GMT+0000 (GMT)*
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
    "connect.sid=s%3A7XATOp4UwqfT9rlyNg6G%2FXjo.qaReaFkYo%2FK72Z3HsDJ3zu2fFWKkDDyocdwx1J%2BU2tI; Path=/"
  ],
  "date": "Fri, 18 Jan 2013 16:07:58 GMT",
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

### ✓ Should set a cookie
```javascript
response.should.have.header 'Set-Cookie'
```

### ✓ Error message is provided
```javascript
json = JSON.parse( response.body )
json.body.error.should.eql "You must provide both 'service' and 'token' params"
```

