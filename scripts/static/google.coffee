
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
  email: 'example@example.com'
  password: 'mySecretPass'

#> Foo Bar
path: '/foo'
method: 'POST'

#? Status: 404
response.statusCode.should.equal 404

#? Response.body should contain '!!1'
response.body.should.include '!!1'

#? Should return a content-type header
response.headers.should.have.property 'content-type', 'text/html; charset=UTF-8'