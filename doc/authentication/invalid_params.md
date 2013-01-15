# Token Auth - Invalid Params

*Generated: Tue Jan 15 2013 10:50:57 GMT+0000 (GMT)*
## Request
```javascript
{
  "host": "stage.bizzby.me",
  "path": "/auth/token",
  "method": "POST",
  "headers": {
    "Accept": "application/json"
  }
}
```

## Response
```javascript
Status: 400
{
  "x-powered-by": "Express",
  "content-type": "application/json",
  "content-length": "81",
  "set-cookie": [
    "connect.sid=s%3AVRcRYsmYUp1PYCFOcvBWoPcB.dzfok9VzNRgPQnVqU3Y2xhEK%2BmxkiNxDTLrbakuKy7s; Path=/"
  ],
  "date": "Tue, 15 Jan 2013 10:51:23 GMT",
  "connection": "keep-alive"
}
```
```javascript
{
  "meta": {},
  "body": {
    "error": "You must provide both 'service' and 'token' params"
  }
}
```

## Tests

# ✓ Status: 400 Bad Request
```javascript
response.statusCode.should.equal 400
```

# ✓ Should set a cookie
```javascript
response.should.have.header 'Set-Cookie'
```

# ✓ Error message is provided
```javascript
json = JSON.parse( response.body )
json.body.error.should.eql "You must provide both 'service' and 'token' params"
```

