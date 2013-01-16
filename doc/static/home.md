# Home Page is Up & Running

*Generated: Wed Jan 16 2013 12:45:23 GMT+0000 (GMT)*
## Request
```javascript
{
  "host": "stage.bizzby.me",
  "path": "/",
  "method": "GET"
}
```

## Response
```javascript
Status: 200
{
  "x-powered-by": "Express",
  "content-type": "text/html; charset=utf-8",
  "content-length": "2178",
  "etag": "\"1801899012\"",
  "set-cookie": [
    "connect.sid=s%3AjTQS7VJLi0In0nPSvBjK9UWy.188xsJGKGfERShvEgggYByFv2IpkskIQ6eAFUX9hRHM; Path=/"
  ],
  "date": "Wed, 16 Jan 2013 12:45:51 GMT",
  "connection": "keep-alive"
}
```
```html
<!DOCTYPE html>
<html lang="en-gb">
  <head>
    <title>Bizzby | Bizzby</title>

    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <meta name="description" content="Bizzby" />

    <link href='http://fonts.googleapis.com/css?family=Viga' rel='stylesheet' />
    <link href='http://fonts.googleapis.com/css?family=Open+Sans:400,600,700' rel='stylesheet' />
    <link href="/style/site.css" rel="stylesheet" />
  </head>

  <body class="">
    <div class="body">
      <header>
        <div class="header">
          <div class="bar">
            <h1 class="title">
        <a href="/">Bizzby</a>
      </h1>

            <div class="auth">
            <p class="logged-out">
              <a href="/app/signin">Signin</a> |
              <a href="/auth/login">Login</a> |
              <a href="/auth/register">Register</a>
            </p>
</div>
    </div>
      
          <nav>
      <ul class="nav">
        <li class="item">
    <span class="current">Home</span>    </li>
    
        <li class="item">
    <a href="/geo/lookup">Geo service</a>    </li>
    
        <li class="item">
    <a href="/task">List tasks</a>    </li>
    
        <li class="item">
    <a href="/task/create">Create task</a>    </li>
    
        <li class="item">
    <a href="/user">List users</a>    </li>
    
        <li class="item">
    <a href="/user/me/edit">Edit profile</a>    </li>
    
        <li class="item">
    <a href="/skill/list">List skills</a>    </li>
    
        <li class="item">
    <a href="/skill/create">Create skill</a>    </li>
    
        <li class="item">
    <a href="/styleguide">Style guide</a>    </li>
    
        <li class="item">
    <a href="/grid">Responsive grid</a>    </li>
      </ul>
    </nav>
  </div>
      </header>

      <div class="main">
              </div>

      <footer>
        <div class="footer">
          <p>Copyright &copy; 2012 Bizzby. All rights reserved.</p>
        </div>
      </footer>
    </div>

    <script src="//ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
    <script src="/lib/site.js"></script>
  </body>
</html>

```

## Tests

### ✓ Should set a cookie
```javascript
response.should.have.header 'Set-Cookie'
```

### ✓ Bad Request
```javascript
response.statusCode.should.equal 200
```

### ✓ Should contain the company name
```javascript
response.body.should.include 'Bizzby'
```

