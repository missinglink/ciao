# Token Auth - Invalid Service

*Generated: Mon Jan 14 2013 18:20:11 GMT+0000 (GMT)*
## Request
```javascript
{
  "host": "stage.bizzby.me",
  "path": "/auth/token",
  "method": "POST",
  "headers": {
    "Accept": "application/json",
    "Content-Type": "application/json"
  },
  "body": {
    "service": "invalid_service",
    "token": "43423"
  }
}
```

## Response
```javascript
{
  "x-powered-by": "Express",
  "content-type": "application/json",
  "content-length": "75",
  "set-cookie": [
    "connect.sid=s%3AmxuMTOWDgVTTn4sywB00TNgq.dyOJj%2F%2FuqGaLRhgRDYplKOaF7lZ%2BzbBRBLsb3Co1LnI; Path=/"
  ],
  "date": "Mon, 14 Jan 2013 18:20:36 GMT",
  "connection": "keep-alive"
}
```
```javascript
{
  "meta": {},
  "body": {
    "error": "The 'service' you specified is not supported"
  }
}
```

## Tests

# ✓ Bad Request
```response.statusCode.should.equal 400

```

# ✓ Error message is provided
```JSON.parse( response.body ).body.error.should.eql "The 'service' you specified is not supported"
```

