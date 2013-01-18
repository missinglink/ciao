# Token Auth - Invalid Token

*Generated: Fri Jan 18 2013 16:07:34 GMT+0000 (GMT)*
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
    "connect.sid=s%3AUmIL%2Bje1UsW8c8iJkklEwoXl.kNt84OBZtjtwmRLM%2B3G8FUmOmsV%2BEANkhBTeVKZnOjA; Path=/"
  ],
  "date": "Fri, 18 Jan 2013 16:07:59 GMT",
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

