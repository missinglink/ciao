# Token Auth - Invalid Service

*Generated: Tue Jan 15 2013 10:50:57 GMT+0000 (GMT)*
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
    "connect.sid=s%3Aj87zUUqhTloFpoDIhWVWDZ3c.PGrO1oDrQGRdDPnCC0kRrgeA5%2FEw2muVl4NPudwq4u4; Path=/"
  ],
  "date": "Tue, 15 Jan 2013 10:51:23 GMT",
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

# ✓ Status: 400 Bad Request
```javascript
response.statusCode.should.equal 400
```

# ✓ Error message is provided
```javascript
json = JSON.parse( response.body )
json.body.error.should.eql "The 'service' you specified is not supported"
```

