# Register new user

*Generated: Mon Jan 28 2013 00:36:29 GMT+0000 (GMT)*
## Request
```javascript
{
  "host": "www.yahoo.co.uk",
  "port": 80,
  "headers": {
    "User-Agent": "Ciao/Client 1.0",
    "Cookie": "foo",
    "Accept": "application/json",
    "Content-Type": "application/json"
  },
  "path": "/",
  "method": "GET",
  "body": {
    "email": "example@example.com",
    "password": "mySecretPass"
  }
}
```

## Response
```javascript
Status: 301
{
  "date": "Mon, 28 Jan 2013 00:31:21 GMT",
  "p3p": "policyref=\"http://info.yahoo.com/w3c/p3p.xml\", CP=\"CAO DSP COR CUR ADM DEV TAI PSA PSD IVAi IVDi CONi TELo OTPi OUR DELi SAMi OTRi UNRi PUBi IND PHY ONL UNI PUR FIN COM NAV INT DEM CNT STA POL HEA PRE LOC GOV\"",
  "cache-control": "max-age=3600, public",
  "location": "http://uk.yahoo.com/",
  "vary": "Accept-Encoding",
  "content-type": "text/html; charset=utf-8",
  "age": "307",
  "content-length": "81",
  "connection": "keep-alive",
  "via": "HTTP/1.1 rc6.ops.ird.yahoo.com (YahooTrafficServer/1.20.10 [cHs f ])",
  "server": "YTS/1.20.10"
}
```
```html
<!-- rc6.ops.ird.yahoo.com uncompressed/chunked Mon Jan 28 00:31:21 UTC 2013 -->

```

## Tests

### ✓ Status: 301
```javascript
response.statusCode.should.equal 301
```

### ✓ Should return a server name
```javascript
response.headers.should.have.property 'server', 'YTS/1.20.10'
```

### ✓ Response should redirect to http://uk.yahoo.com/foo
```javascript
response.headers.should.have.property 'location', 'http://uk.yahoo.com/'
```

