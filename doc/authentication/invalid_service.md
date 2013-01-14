# Token Auth - Invalid Service

*Generated: Mon Jan 14 2013 18:30:25 GMT+0000 (GMT)*
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
400
```
```javascript
{
  "x-powered-by": "Express",
  "content-type": "application/json",
  "content-length": "75",
  "set-cookie": [
    "connect.sid=s%3ABsYK4G5%2FGhPIwUTZky2H3Kzv.uT3h4g3l%2BOnuHGryUyDw7pl%2FUp8HKq1qTe0WSuHcwgg; Path=/"
  ],
  "date": "Mon, 14 Jan 2013 18:30:50 GMT",
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

