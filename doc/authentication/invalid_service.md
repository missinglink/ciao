# Token Auth - Invalid Service

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
    "service": "invalid_service",
    "token": "43423"
  }
}
```

## Response
```javascript
{
  "x-powered-by": "Express",
  "content-type": "application/json",
  "content-length": "75",
  "set-cookie": [
    "connect.sid=s%3ARoH%2FHxYmy9ADuxbaOFh9O2WR.kCqXdyNYxIOmzbe5W6rMi2eFcGjAF%2Ffj2MNXWRe7C8g; Path=/"
  ],
  "date": "Mon, 14 Jan 2013 17:30:31 GMT",
  "connection": "keep-alive"
}
```
## Response
```javascript
{
  "meta": {},
  "body": {
    "error": "The 'service' you specified is not supported"
  }
}
```

