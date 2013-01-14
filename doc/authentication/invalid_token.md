# Token Auth - Invalid Token

*Generated: Mon Jan 14 2013 18:16:03 GMT+0000 (GMT)*
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
{
  "x-powered-by": "Express",
  "content-type": "application/json",
  "content-length": "81",
  "set-cookie": [
    "connect.sid=s%3A%2BnY4ZF8b92ACQNj7S%2Fm4Rzr%2B.WS%2FXCwyp9MFvOgq3b0qFInRtNFj4%2Bku5G37V9rk%2F2ZM; Path=/"
  ],
  "date": "Mon, 14 Jan 2013 18:16:28 GMT",
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

```✓ Error message is provided```
```✓ Bad Request```
