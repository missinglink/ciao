# Token Auth - Invalid Service

*Generated: Mon Jan 14 2013 18:31:37 GMT+0000 (GMT)*
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
    "connect.sid=s%3A1a0vFGwCVfQ3ya3ikrU1TS%2BD.6ewqmjfe83KrFxgYJAyYGcbiHrhWwp90WXlAWe86w%2Fw; Path=/"
  ],
  "date": "Mon, 14 Jan 2013 18:32:02 GMT",
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

## ✓ Error message is provided
```
JSON.parse( response.body ).body.error.should.eql "The 'service' you specified is not supported"
```

## ✓ Bad Request
```
response.statusCode.should.equal 400
```

