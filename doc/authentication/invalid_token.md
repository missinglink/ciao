# Token Auth - Invalid Token

*Generated: Mon Jan 14 2013 18:36:55 GMT+0000 (GMT)*
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
    "connect.sid=s%3APCRfKDhetSxyemHG%2BakWbY6K.gc6tP1SQRg5xLW1K07vydqc3LdHRHGUhi4lNIFlZy14; Path=/"
  ],
  "date": "Mon, 14 Jan 2013 18:37:19 GMT",
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

## ✓ Status: 401 Unauthorized
```javascript
response.statusCode.should.equal 401
```

## ✓ Error message is provided
```javascript
json = JSON.parse( response.body )
json.body.error.should.eql "Your facebook account must share the email address"
```

