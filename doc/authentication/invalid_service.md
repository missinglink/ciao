# Token Auth - Invalid Service

*Generated: Mon Jan 14 2013 18:34:39 GMT+0000 (GMT)*
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
    "connect.sid=s%3A3cb%2FM7X4pUHwnkwK5rj0Ld1I.%2B%2BeoNW%2BPeKOMKmtQo60YSL1kcERA0vR%2BDD4s%2FOnLGkw; Path=/"
  ],
  "date": "Mon, 14 Jan 2013 18:35:04 GMT",
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
json = JSON.parse( response.body )
json.body.error.should.eql "The 'service' you specified is not supported"
```

## ✓ Bad Request
```
response.statusCode.should.equal 400
```

