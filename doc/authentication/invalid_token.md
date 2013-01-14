# Token Auth - Invalid Token

Generated: Mon Jan 14 2013 17:13:46 GMT+0000 (GMT)
## Request
```
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
```
{
  "meta": {},
  "body": {
    "error": "Your facebook account must share the email address"
  }
}
```

