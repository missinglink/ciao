# Token Auth - Invalid Service

*Generated: Wed Jan 16 2013 14:53:01 GMT+0000 (GMT)*
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
    "connect.sid=s%3A6Is2p2eoxExQe4akMoPVdOpI.3dEJPF7qk26H3i6mvzHVLu9IeyCH8pCLtaz%2FKrJ06sQ; Path=/"
  ],
  "date": "Wed, 16 Jan 2013 14:53:26 GMT",
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

### ✓ Error message is provided
```javascript
json = JSON.parse( response.body )
json.body.error.should.eql "The 'service' you specified is not supported"
```

### ✓ Status: 400 Bad Request
```javascript
response.statusCode.should.equal 400
```

