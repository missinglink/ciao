# Token Auth - Invalid Service

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

