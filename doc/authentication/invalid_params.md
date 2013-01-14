# Token Auth - Invalid Params

*Generated: Mon Jan 14 2013 18:35:17 GMT+0000 (GMT)*
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
    "connect.sid=s%3Ae4a4%2Fiz1gQMJgUlQzbgO1kbB.PFKEoCzS89laP8HnVpr3baYlmaiL33TqRdYXUmQWs88; Path=/"
  ],
  "date": "Mon, 14 Jan 2013 18:35:42 GMT",
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

## ✓ Bad Request
```javascript
response.statusCode.should.equal 400
```

## ✓ Error message is provided
```javascript
json = JSON.parse( response.body )
json.body.error.should.eql "You must provide both 'service' and 'token' params"
```

