# Token Auth - Invalid Params

*Generated: Mon Jan 14 2013 17:30:05 GMT+0000 (GMT)*
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

## Response
```javascript
{
  "x-powered-by": "Express",
  "content-type": "application/json",
  "content-length": "81",
  "set-cookie": [
    "connect.sid=s%3AYptu6yc0WiCEuu3DWWs9Ou4T.sKTGXsGbb4OqIapmDb1eUQqQId1n%2Fpxn9MnRm0aUnf8; Path=/"
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
    "error": "You must provide both 'service' and 'token' params"
  }
}
```

