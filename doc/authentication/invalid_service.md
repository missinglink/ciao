# Token Auth - Invalid Service

*Generated: Fri Jan 18 2013 16:07:33 GMT+0000 (GMT)*
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
Status: 400
{
  "x-powered-by": "Express",
  "content-type": "application/json",
  "content-length": "75",
  "set-cookie": [
    "connect.sid=s%3AXlYIY6gMulBTFPFlQcG6s6%2Be.UniJ2PxHP%2BqA0paIY2aX%2FLId6ztEYGD0GDY4IX%2Boie4; Path=/"
  ],
  "date": "Fri, 18 Jan 2013 16:07:58 GMT",
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

### ✓ Status: 400 Bad Request
```javascript
response.statusCode.should.equal 400
```

### ✓ Error message is provided
```javascript
json = JSON.parse( response.body )
json.body.error.should.eql "The 'service' you specified is not supported"
```

