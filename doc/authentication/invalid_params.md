# Token Auth - Invalid Params

*Generated: Mon Jan 14 2013 18:37:26 GMT+0000 (GMT)*
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
{
  "x-powered-by": "Express",
  "content-type": "application/json",
  "content-length": "81",
  "set-cookie": [
    "connect.sid=s%3ABBT6VGS26xF6yure8nbOgK3m.Rcf0lxucwq9wa9UE%2FDtMKN%2F4le8aHp86X16MmzgGPHU; Path=/"
  ],
  "date": "Mon, 14 Jan 2013 18:37:51 GMT",
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

## ✓ Error message is provided
```javascript
json = JSON.parse( response.body )
json.body.error.should.eql "You must provide both 'service' and 'token' params"
```

## ✓ Should set a cookie
```javascript
response.should.have.header 'Set-Cookie'
```

## ✓ Status: 400 Bad Request
```javascript
response.statusCode.should.equal 400
```

