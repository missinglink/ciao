# Token Auth - Invalid Service

*Generated: Mon Jan 14 2013 18:31:13 GMT+0000 (GMT)*
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
```
```javascript
{
  "x-powered-by": "Express",
  "content-type": "application/json",
  "content-length": "75",
  "set-cookie": [
    "connect.sid=s%3Ajwv3soc%2FDncs9iZvreGuiTw3.B4wbcrlpoU%2B2NcflMZGETZ3xq9jo98DhTOQtXUPup8o; Path=/"
  ],
  "date": "Mon, 14 Jan 2013 18:31:38 GMT",
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

