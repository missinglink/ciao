# Token Auth - Invalid Params

*Generated: Mon Jan 14 2013 18:51:10 GMT+0000 (GMT)*
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
    "connect.sid=s%3Ay%2Bs1m4SNjFgWQkPJi%2FRsnM%2Br.a8EvNckBxwaiDQxEzWtpEqIS4zWFR5yQZdiUHu%2Bb%2FEo; Path=/"
  ],
  "date": "Mon, 14 Jan 2013 18:51:34 GMT",
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
```javascript
response.should.have.header 'Set-Cookie'
```

## ✓ Status: 400 Bad Request
```javascript
response.statusCode.should.equal 400
```

## ✓ Error message is provided
```javascript
json = JSON.parse( response.body )
json.body.error.should.eql "You must provide both 'service' and 'token' params"
```

