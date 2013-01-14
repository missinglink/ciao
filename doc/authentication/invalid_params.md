# Token Auth - Invalid Params

*Generated: Mon Jan 14 2013 17:30:30 GMT+0000 (GMT)*
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
    "connect.sid=s%3AQJYQDa0bXBIW%2Fq%2F5yexmo59r.JrEP71G0wyVQJyxDzNkfg%2Fp3cjinZOJzIC%2Fzot3%2FnvI; Path=/"
  ],
  "date": "Mon, 14 Jan 2013 17:30:57 GMT",
  "connection": "keep-alive"
}
```
```javascript
{
  "meta": {},
  "body": {
    "error": "You must provide both 'service' and 'token' params"
  }
}
```

