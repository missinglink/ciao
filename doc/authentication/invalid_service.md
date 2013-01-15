# Token Auth - Invalid Service

*Generated: Tue Jan 15 2013 10:52:18 GMT+0000 (GMT)*
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
    "connect.sid=s%3AeqsBp2e7OahuFlt28GPyN0VT.7lm04gsCoYNUNWp1mwR2cWwPtvs%2FbC%2FicGy1XFGpafA; Path=/"
  ],
  "date": "Tue, 15 Jan 2013 10:52:44 GMT",
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

