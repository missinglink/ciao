# Token Auth - Invalid Service

*Generated: Mon Jan 14 2013 17:24:38 GMT+0000 (GMT)*
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

## Response Headers
```javascript
{
  "x-powered-by": "Express",
  "content-type": "application/json",
  "content-length": "75",
  "set-cookie": [
    "connect.sid=s%3A3ZT2%2BBN5%2FOFm4%2B3lPj2p2I8V.8CatLP2K7xjlPGeeEann%2FxTYTW5FZJN3%2Bjp9Qh6iy7k; Path=/"
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
    "error": "The 'service' you specified is not supported"
  }
}
```

