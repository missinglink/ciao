# Token Auth - Invalid Params

*Generated: Wed Jan 16 2013 14:53:01 GMT+0000 (GMT)*
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
    "connect.sid=s%3A0SFHGD02rEbzETruXq0WqJ0Q.TykkavwuQWyFzqkuO2hS2Lz4fYmrAVL3qmbsqOOS9Uc; Path=/"
  ],
  "date": "Wed, 16 Jan 2013 14:53:26 GMT",
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

### ✓ Status: 400 Bad Request
```javascript
response.statusCode.should.equal 400
```

### ✓ Error message is provided
```javascript
json = JSON.parse( response.body )
json.body.error.should.eql "You must provide both 'service' and 'token' params"
```

