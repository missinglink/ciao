# Token Auth - Invalid Service

*Generated: Mon Jan 14 2013 17:16:05 GMT+0000 (GMT)*
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
    "service": "invalid_service",
    "token": "43423"
  }
}
```

## Response
```
{
  "meta": {},
  "body": {
    "error": "The 'service' you specified is not supported"
  }
}
```

