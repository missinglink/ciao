# Token Auth - Invalid Token

*Generated: Mon Jan 14 2013 18:51:11 GMT+0000 (GMT)*
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
    "connect.sid=s%3AQRLk%2FADQU2%2FtMIeaIF7v%2B2rd.ck2ws3BkqdnpF8luFCrbntqyN%2BuvOYwssmhkAFCfhx4; Path=/"
  ],
  "date": "Mon, 14 Jan 2013 18:51:35 GMT",
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

## ✓ Error message is provided
```javascript
json = JSON.parse( response.body )
json.body.error.should.eql "Your facebook account must share the email address"
```

## ✓ Status: 401 Unauthorized
```javascript
response.statusCode.should.equal 401
```

