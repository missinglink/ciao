# Token Auth - Invalid Token

*Generated: Mon Jan 14 2013 18:35:18 GMT+0000 (GMT)*
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
    "connect.sid=s%3AsMyW8onSjaJjMT9azXPzYUTT.bsmfYM%2BnXxoLqHdeoPHiFaFwc7CL43J3%2FrBngOjcq9E; Path=/"
  ],
  "date": "Mon, 14 Jan 2013 18:35:42 GMT",
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

## ✓ Bad Request
```javascript
response.statusCode.should.equal 401
```

## ✓ Error message is provided
```javascript
json = JSON.parse( response.body )
json.body.error.should.eql "Your facebook account must share the email address"
```

