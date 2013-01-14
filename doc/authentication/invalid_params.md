# Token Auth - Invalid Params

*Generated: Mon Jan 14 2013 18:16:02 GMT+0000 (GMT)*
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
    "connect.sid=s%3AX9etUW2EfLrAA03SkLFUme2C.tajKUap2M4LN9D%2BNR5eM2UvawFkA%2FdkT7JCHNMAxnG4; Path=/"
  ],
  "date": "Mon, 14 Jan 2013 18:16:27 GMT",
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

## Tests

```✓ Bad Request```
```✓ Error message is provided```
```✓ Should set a cookie```
