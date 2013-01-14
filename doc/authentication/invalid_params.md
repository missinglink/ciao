# Token Auth - Invalid Params

*Generated: Mon Jan 14 2013 18:21:37 GMT+0000 (GMT)*
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
    "connect.sid=s%3ALPLKecGgQz0KcDsXR8Qx8jK9.kfmq8v1tZgDtSpp5XUHQhyH3qqa5%2BbS3iXiZa07VqBA; Path=/"
  ],
  "date": "Mon, 14 Jan 2013 18:22:02 GMT",
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

## ✓ Bad Request
```
response.statusCode.should.equal 400


```

## ✓ Should set a cookie
```
response.should.have.header 'Set-Cookie'


```

## ✓ Error message is provided
```
JSON.parse( response.body ).body.error.should.eql "You must provide both 'service' and 'token' params"

```

