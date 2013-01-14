# Token Auth - Invalid Params

*Generated: Mon Jan 14 2013 18:30:25 GMT+0000 (GMT)*
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
400
```
```javascript
{
  "x-powered-by": "Express",
  "content-type": "application/json",
  "content-length": "81",
  "set-cookie": [
    "connect.sid=s%3A%2FoyACHCGp1XOjiov%2FW0kwAao.ncsFF%2BDsno41SQiEyjzGRi%2F1zuHczrlcf%2BiqQsCLq88; Path=/"
  ],
  "date": "Mon, 14 Jan 2013 18:30:50 GMT",
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

## ✓ Bad Request
```
response.statusCode.should.equal 400
```

## ✓ Error message is provided
```
JSON.parse( response.body ).body.error.should.eql "You must provide both 'service' and 'token' params"
```

## ✓ Should set a cookie
```
response.should.have.header 'Set-Cookie'
```

