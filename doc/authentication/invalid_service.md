# Token Auth - Invalid Service

*Generated: Mon Jan 14 2013 17:30:30 GMT+0000 (GMT)*
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
    "connect.sid=s%3ASKvMRfQkLCj%2BMN7EKrHLzgnb.7rctr9VM%2BIs7G7GXggnrqPyBWRwkUb0z1vwAEN7pDHk; Path=/"
  ],
  "date": "Mon, 14 Jan 2013 17:30:57 GMT",
  "connection": "keep-alive"
}
```
```javascript
{
  "meta": {},
  "body": {
    "error": "The 'service' you specified is not supported"
  }
}
```

