# Token Auth - Invalid Params

*Generated: Mon Jan 14 2013 18:34:39 GMT+0000 (GMT)*
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
    "connect.sid=s%3Ajmam1YTSng5CxvtWcwQ8cao0.gsqPKCcEmLsWDywHMzFRKkYaq62TLMmhtaAFTSYJ1qM; Path=/"
  ],
  "date": "Mon, 14 Jan 2013 18:35:04 GMT",
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
json = JSON.parse( response.body )
json.body.error.should.eql "You must provide both 'service' and 'token' params"
```

