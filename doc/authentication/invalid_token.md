# Token Auth - Invalid Token

*Generated: Mon Jan 14 2013 18:34:40 GMT+0000 (GMT)*
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
    "connect.sid=s%3AaRvzg6UMoG%2FW%2F9tQXy9xCkgY.NXIPlZKMAqdI%2FzqcD4eUzPFCyYjjw2S8OZNM7XDbsEk; Path=/"
  ],
  "date": "Mon, 14 Jan 2013 18:35:04 GMT",
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
```
response.statusCode.should.equal 401
```

## ✓ Error message is provided
```
json = JSON.parse( response.body )
json.body.error.should.eql "Your facebook account must share the email address"
```

