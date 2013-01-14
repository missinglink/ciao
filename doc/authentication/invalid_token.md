# Token Auth - Invalid Token

*Generated: Mon Jan 14 2013 18:19:00 GMT+0000 (GMT)*
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
{
  "x-powered-by": "Express",
  "content-type": "application/json",
  "content-length": "81",
  "set-cookie": [
    "connect.sid=s%3A0ZJrIFRzJJEOWZFOrjylpUaW.Xw3U2m5ND7djXpxbnkwYQUZqNlTnsJ83Dff0PALEBUs; Path=/"
  ],
  "date": "Mon, 14 Jan 2013 18:19:25 GMT",
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

# Bad Request
```✓ response.statusCode.should.equal 401

```
# Error message is provided
```✓ JSON.parse( response.body ).body.error.should.eql "Your facebook account must share the email address"
```
