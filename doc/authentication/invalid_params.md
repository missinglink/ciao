# Token Auth - Invalid Params

*Generated: Mon Jan 14 2013 17:24:38 GMT+0000 (GMT)*
## Request
```javascript
{
  "host": "stage.bizzby.me",
  "path": "/auth/token",
  "method": "POST",
  "headers": {
    "Accept": "application/json"
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
    "connect.sid=s%3AQw2G2XPaVj70ae%2B1XGdFejjI.012RdJMZz9SKCx2XRDEjvC%2BkYTcEbHqOu8QtakgaFic; Path=/"
  ],
  "date": "Mon, 14 Jan 2013 17:25:05 GMT",
  "connection": "keep-alive"
}
```

## Response
```javascript
{
  "meta": {},
  "body": {
    "error": "You must provide both 'service' and 'token' params"
  }
}
```

