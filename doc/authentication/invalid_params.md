# Token Auth - Invalid Params

*Generated: Mon Jan 14 2013 18:23:27 GMT+0000 (GMT)*
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
{
  "x-powered-by": "Express",
  "content-type": "application/json",
  "content-length": "81",
  "set-cookie": [
    "connect.sid=s%3AM02INr1a%2FR1IQLN3%2FH0B02tj.4PeeMoQlESpYXdXXQukWopmjNrNEPrGfjNuC8Eqc6VY; Path=/"
  ],
  "date": "Mon, 14 Jan 2013 18:23:52 GMT",
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

## ✓ Should set a cookie
```
response.should.have.header 'Set-Cookie'
```

## ✓ Bad Request
```
response.statusCode.should.equal 400
```

## ✓ Error message is provided
```
JSON.parse( response.body ).body.error.should.eql "You must provide both 'service' and 'token' params"
```

