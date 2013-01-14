# Token Auth - Invalid Service

*Generated: Mon Jan 14 2013 18:35:17 GMT+0000 (GMT)*
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
    "connect.sid=s%3Az45D%2FczYYYAbwRTAttT%2BqghP.KItOMe9jdUnkHDdul7ND4JHx5lLDMv7K%2BI%2F6ibvKL%2BI; Path=/"
  ],
  "date": "Mon, 14 Jan 2013 18:35:42 GMT",
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
```javascript
response.statusCode.should.equal 400
```

## ✓ Error message is provided
```javascript
json = JSON.parse( response.body )
json.body.error.should.eql "The 'service' you specified is not supported"
```

