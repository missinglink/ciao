# Token Auth - Invalid Params

*Generated: Mon Jan 14 2013 18:31:13 GMT+0000 (GMT)*
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
```
```javascript
{
  "x-powered-by": "Express",
  "content-type": "application/json",
  "content-length": "81",
  "set-cookie": [
    "connect.sid=s%3A0N%2FFF%2Fk5Sjb3ktStpjhf1x16.N2lpIiPQsa29MfgOm05SsQCFtPWKEm0TYtlwweTew7c; Path=/"
  ],
  "date": "Mon, 14 Jan 2013 18:31:38 GMT",
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

