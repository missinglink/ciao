# Token Auth - Invalid Token

*Generated: Mon Jan 14 2013 17:30:31 GMT+0000 (GMT)*
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
    "service": "facebook",
    "token": "43423"
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
    "connect.sid=s%3Atpf1j9opRqarQjVIT3GkbpcY.HW4I9UaBUaPH1TPsfxXf%2BigSUSmColxXY4A2F84GLwE; Path=/"
  ],
  "date": "Mon, 14 Jan 2013 17:30:58 GMT",
  "connection": "keep-alive"
}
```
```javascript
{
  "meta": {},
  "body": {
    "error": "Your facebook account must share the email address"
  }
}
```

