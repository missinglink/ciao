# Token Auth - Invalid Token

*Generated: Mon Jan 14 2013 18:38:36 GMT+0000 (GMT)*
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
    "connect.sid=s%3AtSKkHguQRRZKSnzJ3O%2FzS%2FnE.7%2FLGqGgboATzazjcp39Kw3LfOwKHL3SviD%2B8AXwuFic; Path=/"
  ],
  "date": "Mon, 14 Jan 2013 18:39:00 GMT",
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

## ✓ Error message is provided
```javascript
json = JSON.parse( response.body )
json.body.error.should.eql "Your facebook account must share the email address"
```

## ✓ Status: 401 Unauthorized
```javascript
response.statusCode.should.equal 401
```

