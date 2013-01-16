# Token Auth - Invalid Service

*Generated: Wed Jan 16 2013 12:45:23 GMT+0000 (GMT)*
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
    "connect.sid=s%3AKiHYJM5IsDTrWYhKUSJ7FMQ3.S4gHvrmSZeqvu6sfnO%2FJrpjPxC1cNnWPcbbbYDV77IY; Path=/"
  ],
  "date": "Wed, 16 Jan 2013 12:45:51 GMT",
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

### ✘ Status: 400 Bad Request
```javascript
response.statusCode.should.equal 401
```
expected 400 to equal 401


### ✓ Error message is provided
```javascript
json = JSON.parse( response.body )
json.body.error.should.eql "The 'service' you specified is not supported"
```

