# Token Auth - Invalid Service

*Generated: Mon Jan 14 2013 18:16:02 GMT+0000 (GMT)*
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
    "connect.sid=s%3Awz6bwAIwcNTQtNsSxWwfPi4O.EnRvF6nD2t0Jz4RhFV2YdKybz3oODHuBmLs4GAmkpIM; Path=/"
  ],
  "date": "Mon, 14 Jan 2013 18:16:27 GMT",
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

## Tests

```✓ Bad Request```
```✓ Error message is provided```
