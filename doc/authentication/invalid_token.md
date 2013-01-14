# Token Auth - Invalid Token

*Generated: Mon Jan 14 2013 18:31:14 GMT+0000 (GMT)*
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
    "service": "facebook",
    "token": "43423"
  }
}
```

## Response
```javascript
Status: 401
```
```javascript
{
  "x-powered-by": "Express",
  "content-type": "application/json",
  "content-length": "81",
  "set-cookie": [
    "connect.sid=s%3AxGkVPFTqEQX4xMY6rPywGpkD.v18%2BDemWAHWfcNKIKFI%2B9CJSdmWiUhrr5ruIo1lMPI0; Path=/"
  ],
  "date": "Mon, 14 Jan 2013 18:31:38 GMT",
  "connection": "keep-alive"
}
```
```javascript
{
  "meta": {},
  "body": {
    "error": "Your facebook account must share the email address"
  }
}
```

## Tests

## ✓ Error message is provided
```
JSON.parse( response.body ).body.error.should.eql "Your facebook account must share the email address"
```

## ✓ Bad Request
```
response.statusCode.should.equal 401
```

