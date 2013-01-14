# Token Auth - Invalid Service

*Generated: Mon Jan 14 2013 18:51:10 GMT+0000 (GMT)*
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
    "connect.sid=s%3AyOwEyGSuT9dPQTownPExsfTe.6cytRH9s%2BccXS3XtoeeBL5v1hKbzpqKQWGPfmzS%2BMRk; Path=/"
  ],
  "date": "Mon, 14 Jan 2013 18:51:34 GMT",
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

## ✓ Status: 400 Bad Request
```javascript
response.statusCode.should.equal 400
```

## ✓ Error message is provided
```javascript
json = JSON.parse( response.body )
json.body.error.should.eql "The 'service' you specified is not supported"
```

