# Token Auth - Invalid Token

*Generated: Mon Jan 14 2013 17:30:05 GMT+0000 (GMT)*
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
    "connect.sid=s%3A6scZruDklw7EFmOiegjPvUAd.ppOfoakuP2oQtC2Ru%2BUCk9a9ytc%2B2YKje8GENwHJQvk; Path=/"
  ],
  "date": "Mon, 14 Jan 2013 17:30:32 GMT",
  "connection": "keep-alive"
}
```
## Response
```javascript
{
  "meta": {},
  "body": {
    "error": "Your facebook account must share the email address"
  }
}
```

