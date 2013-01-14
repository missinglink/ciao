# Token Auth - Invalid Service

*Generated: Mon Jan 14 2013 18:21:37 GMT+0000 (GMT)*
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
    "connect.sid=s%3AR2h7SQf5D4UGmlXxlNrNySwE.O0ZMJRMfDgLO%2F%2F2kWIk1elDLDSfXxfVNjsd%2FWAgNITo; Path=/"
  ],
  "date": "Mon, 14 Jan 2013 18:22:02 GMT",
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

