# Register new user

*Generated: Sun Jan 27 2013 21:52:22 GMT+0000 (GMT)*
## Request
```javascript
{
  "host": "www.google.co.uk",
  "port": 80,
  "headers": {
    "User-Agent": "Ciao/Client 1.0",
    "Cookie": "foo",
    "Accept": "application/json",
    "Content-Type": "application/json"
  },
  "path": "/foo",
  "method": "POST",
  "body": {
    "email": "example@example.com",
    "password": "mySecretPass"
  }
}
```

## Response
```javascript
Status: 404
{
  "content-type": "text/html; charset=UTF-8",
  "x-content-type-options": "nosniff",
  "date": "Sun, 27 Jan 2013 21:52:13 GMT",
  "server": "sffe",
  "content-length": "934",
  "x-xss-protection": "1; mode=block"
}
```
```html
<!DOCTYPE html>
<html lang=en>
  <meta charset=utf-8>
  <meta name=viewport content="initial-scale=1, minimum-scale=1, width=device-width">
  <title>Error 404 (Not Found)!!1</title>
  <style>
    *{margin:0;padding:0}html,code{font:15px/22px arial,sans-serif}html{background:#fff;color:#222;padding:15px}body{margin:7% auto 0;max-width:390px;min-height:180px;padding:30px 0 15px}* > body{background:url(//www.google.com/images/errors/robot.png) 100% 5px no-repeat;padding-right:205px}p{margin:11px 0 22px;overflow:hidden}ins{color:#777;text-decoration:none}a img{border:0}@media screen and (max-width:772px){body{background:none;margin-top:0;max-width:none;padding-right:0}}
  </style>
  <a href=//www.google.com/><img src=//www.google.com/images/errors/logo_sm.gif alt=Google></a>
  <p><b>404.</b> <ins>That’s an error.</ins>
  <p>The requested URL <code>/foo</code> was not found on this server.  <ins>That’s all we know.</ins>

```

## Tests

### ✓ Status: 404
```javascript
response.statusCode.should.equal 404
```

### ✓ Response.body should contain '!!1'
```javascript
response.body.should.include '!!1'
```

### ✓ Should return a content-type header
```javascript
response.headers.should.have.property 'content-type', 'text/html; charset=UTF-8'
```

