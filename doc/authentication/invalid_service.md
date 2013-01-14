# Token Auth - Invalid Service

*Generated: Mon Jan 14 2013 18:36:54 GMT+0000 (GMT)*
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
    "connect.sid=s%3Aiat1YUWX1PhzjzGlbkGnxdOC.GiEQE9jwsPplJ3n9u%2FZYapArOilkFGMfV6ux1mPwvjw; Path=/"
  ],
  "date": "Mon, 14 Jan 2013 18:37:18 GMT",
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
```javascript
json = JSON.parse( response.body )
json.body.error.should.eql "The 'service' you specified is not supported"
```

## ✓ Status: 400 Bad Request
```javascript
response.statusCode.should.equal 400
```

