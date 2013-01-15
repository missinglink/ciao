# Token Auth - Invalid Token

*Generated: Tue Jan 15 2013 10:50:58 GMT+0000 (GMT)*
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
    "connect.sid=s%3AIbbe%2F6Dg6Vk1%2FBchF6I31Odj.PFYnocY%2F%2FwYECzI6E1Ns1ZeNTikBAipIc%2F3gHvhpqK4; Path=/"
  ],
  "date": "Tue, 15 Jan 2013 10:51:24 GMT",
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

# ✓ Error message is provided
```javascript
json = JSON.parse( response.body )
json.body.error.should.eql "Your facebook account must share the email address"
```

# ✓ Status: 401 Unauthorized
```javascript
response.statusCode.should.equal 401
```

