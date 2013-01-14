# Token Auth - Invalid Token

*Generated: Mon Jan 14 2013 17:24:39 GMT+0000 (GMT)*
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

## Response Headers
```javascript
{
  "x-powered-by": "Express",
  "content-type": "application/json",
  "content-length": "81",
  "set-cookie": [
    "connect.sid=s%3AXrg9NLhXAQ5SNDl3lIXs6b8B.uKlQkuRg6WPvmhW4slLgHjvzsB%2FsGA90q1gZhfxZV4M; Path=/"
  ],
  "date": "Mon, 14 Jan 2013 17:25:06 GMT",
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

