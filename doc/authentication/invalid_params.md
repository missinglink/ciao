# Token Auth - Invalid Params

*Generated: Mon Jan 14 2013 18:31:37 GMT+0000 (GMT)*
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
    "connect.sid=s%3AkndiC8CFb1geeDc8MoNl8Gdb.%2BLfbhg7v9khNCRvhiVHDKKFQrQV%2B%2FP3qyP0LMj8JSuw; Path=/"
  ],
  "date": "Mon, 14 Jan 2013 18:32:02 GMT",
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

## ✓ Bad Request
```
response.statusCode.should.equal 400
```

## ✓ Error message is provided
```
JSON.parse( response.body ).body.error.should.eql "You must provide both 'service' and 'token' params"
```

## ✓ Should set a cookie
```
response.should.have.header 'Set-Cookie'
```

