# Try to confuse google

*Generated: Wed Jan 30 2013 23:28:03 GMT+0000 (GMT)*
## Request
```javascript
{
  "protocol": "http:",
  "host": "www.google.com",
  "method": "POST",
  "port": 80,
  "path": "/",
  "headers": {
    "User-Agent": "Ciao/Client 1.0",
    "Accept": "application/json",
    "Content-Type": "application/json"
  },
  "body": {
    "email": "example@example.com",
    "password": "mySecretPass"
  }
}
```

## Response
```javascript
Status: 405
{
  "allow": "GET, HEAD",
  "date": "Wed, 30 Jan 2013 23:27:58 GMT",
  "content-type": "text/html; charset=UTF-8",
  "server": "gws",
  "content-length": "959",
  "x-xss-protection": "1; mode=block",
  "x-frame-options": "SAMEORIGIN",
  "connection": "close"
}
```
```html
<!DOCTYPE html>
<html lang=en>
  <meta charset=utf-8>
  <meta name=viewport content="initial-scale=1, minimum-scale=1, width=device-width">
  <title>Error 405 (Method Not Allowed)!!1</title>
  <style>
    *{margin:0;padding:0}html,code{font:15px/22px arial,sans-serif}html{background:#fff;color:#222;padding:15px}body{margin:7% auto 0;max-width:390px;min-height:180px;padding:30px 0 15px}* > body{background:url(//www.google.com/images/errors/robot.png) 100% 5px no-repeat;padding-right:205px}p{margin:11px 0 22px;overflow:hidden}ins{color:#777;text-decoration:none}a img{border:0}@media screen and (max-width:772px){body{background:none;margin-top:0;max-width:none;padding-right:0}}
  </style>
  <a href=//www.google.com/><img src=//www.google.com/images/errors/logo_sm.gif alt=Google></a>
  <p><b>405.</b> <ins>That’s an error.</ins>
  <p>The request method <code>POST</code> is inappropriate for the URL <code>/</code>.  <ins>That’s all we know.</ins>

```

## Tests

### ✓ Should return a content-type header
```javascript
response.should.have.header 'content-type', 'text/html; charset=UTF-8'
```

### ✓ Response.body should contain '!!1'
```javascript
response.body.should.containEql '!!1'
```

### ✓ Status: 405 Method Not Allowed
```javascript
response.statusCode.should.equal 405
```

