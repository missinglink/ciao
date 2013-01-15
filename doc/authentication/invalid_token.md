# Token Auth - Invalid Token

*Generated: Tue Jan 15 2013 10:52:19 GMT+0000 (GMT)*
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
    "connect.sid=s%3AvX0yXPC9WETYUvJ5fjdR2Z7A.o%2FEH%2BAyzhozrD1kN6Qm6SWqZ13jjdXE3hp%2B9AyCH%2FP4; Path=/"
  ],
  "date": "Tue, 15 Jan 2013 10:52:45 GMT",
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

