# Token Auth - Invalid Service

Generated: Mon Jan 14 2013 17:13:45 GMT+0000 (GMT)
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

