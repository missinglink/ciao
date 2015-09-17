
#! Requried Headers
headers: 'User-Agent': 'Ciao/Client 1.0'

#! Log in
headers: 'Cookie': config['tester@test.com']

#> Register new user
path: '/'
method: 'GET'
headers:
  'Accept': 'application/json'
  'Content-Type': 'application/json'
body: 
  first_name: 'Fabrizio'
  last_name: 'Moscon'
  email: "fabrizio#{Date.now()}@gmail.com"
  password: 'mySecretPass'

#> Foo Bar
path: '/foo'
method: 'POST'

## This is a junk section
Please ignore this Junk Section

#? Status: 303 See other
response.statusCode.should.equal 302

#? Response has a Content-Type header
response.headers.should.have.property 'content-type', 'text/html; charset=ISO-8859-1'

#? Response body should contain specific js
response.body.should.containEql 'window.attachEvent'

#? Should set a cookie
response.headers.should.have.property 'set-cookie'