# Token Auth - Invalid Token

*Generated: Wed Jan 16 2013 14:53:02 GMT+0000 (GMT)*
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
    "service": "facebook",
    "token": "43423"
  }
}
```

## Response
```javascript
Status: 401
{
  "x-powered-by": "Express",
  "content-type": "application/json",
  "content-length": "81",
  "set-cookie": [
    "connect.sid=s%3A6y5I6UdunGsdVL987zdAqBWd.JfHQQbPv7gsDc3v2on%2Ft5myOsT1SSJELairuXyacLQQ; Path=/"
  ],
  "date": "Wed, 16 Jan 2013 14:53:26 GMT",
  "connection": "keep-alive"
}
```
```javascript
{
  "meta": {},
  "body": {
    "error": "Your facebook account must share the email address"
  }
}
```

## Tests

### ✓ Error message is provided
```javascript
json = JSON.parse( response.body )
json.body.error.should.eql "Your facebook account must share the email address"
```

### ✓ Status: 401 Unauthorized
```javascript
response.statusCode.should.equal 401
```

