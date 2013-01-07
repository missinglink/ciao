


define 'user.login',

  method: 'POST'
  uri: 'http://www.google.com/login'
  form: 
    email: 'test@example.com'
    password: '1234567890'

test 'user.login', (req,response) ->

  response.code.should.equal 200





import 'user.login'



define 'static.home'

  uri: '/login'


test 'static.home', (response) ->

  response.code.should.equal 200
  response.body.should.include "I'm feeling lucky!"

run()




GET / HTTP/1.1
Host: tonycode.com

HTTP/1.1 200 OK
Date: Thu, 12 Jul 2007 16:10:02 GMT
Server: Apache/1.3.37 (Unix) mod_throttle/3.1.2 DAV/1.0.3 mod_fastcgi/2.4.2 mod_gzip/1.3.26.1a PHP/4.4.7 mod_ssl/2.8.22 OpenSSL/0.9.7e
MS-Author-Via: DAV
Last-Modified: Wed, 11 Jul 2007 14:10:28 GMT
ETag: "19cf7aa-68d-4694e4d4"
Accept-Ranges: bytes
Content-Length: 1677
Content-Type: text/html

<!DOCTYPE html PUBLIC "-//W3C//DTD