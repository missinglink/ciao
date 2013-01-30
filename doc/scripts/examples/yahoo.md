# Register new user

*Generated: Wed Jan 30 2013 23:28:03 GMT+0000 (GMT)*
## Request
```javascript
{
  "protocol": "http:",
  "host": "www.yahoo.co.uk",
  "method": "GET",
  "port": 80,
  "path": "/",
  "headers": {
    "User-Agent": "Ciao/Client 1.0"
  }
}
```

## Response
```javascript
Status: 301
{
  "date": "Wed, 30 Jan 2013 23:21:50 GMT",
  "p3p": "policyref=\"http://info.yahoo.com/w3c/p3p.xml\", CP=\"CAO DSP COR CUR ADM DEV TAI PSA PSD IVAi IVDi CONi TELo OTPi OUR DELi SAMi OTRi UNRi PUBi IND PHY ONL UNI PUR FIN COM NAV INT DEM CNT STA POL HEA PRE LOC GOV\"",
  "cache-control": "max-age=3600, public",
  "location": "http://uk.yahoo.com/",
  "vary": "Accept-Encoding",
  "content-type": "text/html; charset=utf-8",
  "age": "368",
  "content-length": "81",
  "connection": "close",
  "via": "HTTP/1.1 rc1.ops.ird.yahoo.com (YahooTrafficServer/1.20.10 [cHs f ])",
  "server": "YTS/1.20.10"
}
```
```html
<!-- rc1.ops.ird.yahoo.com uncompressed/chunked Wed Jan 30 23:21:50 UTC 2013 -->

```

## Tests

### ✓ Status: 301
```javascript
response.statusCode.should.equal 301
```

### ✓ Response should redirect to http://uk.yahoo.com/foo
```javascript
response.should.have.header 'location', 'http://uk.yahoo.com/'
```

### ✓ Should return a server name
```javascript
response.should.have.header 'server', 'YTS/1.20.10'
```

