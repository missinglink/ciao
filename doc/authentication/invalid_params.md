# Token Auth - Invalid Params

*Generated: Mon Jan 14 2013 18:38:35 GMT+0000 (GMT)*
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
    "connect.sid=s%3ATi4bktNyBiNqTCbDVH54XTaV.9hVQwhECyJ8Ge1kYa2TDPfUYODbMB9Jehq1OqRlleOg; Path=/"
  ],
  "date": "Mon, 14 Jan 2013 18:38:59 GMT",
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

## ✓ Status: 400 Bad Request
```javascript
response.statusCode.should.equal 400
```

## ✓ Should set a cookie
```javascript
response.should.have.header 'Set-Cookie'
```

## ✓ Error message is provided
```javascript
json = JSON.parse( response.body )
json.body.error.should.eql "You must provide both 'service' and 'token' params"
```

