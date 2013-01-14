# Token Auth - Invalid Service

*Generated: Mon Jan 14 2013 18:23:27 GMT+0000 (GMT)*
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
    "connect.sid=s%3Amg%2BPzpCP7kPGS1p7%2BG0VOf9M.LWXFz33OyLKhc3Rkg4%2BpFMa2Ot%2BjfLQEXf%2FR%2BTgW2Uw; Path=/"
  ],
  "date": "Mon, 14 Jan 2013 18:23:52 GMT",
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

## ✓ Bad Request
```
response.statusCode.should.equal 400
```

## ✓ Error message is provided
```
JSON.parse( response.body ).body.error.should.eql "The 'service' you specified is not supported"
```

