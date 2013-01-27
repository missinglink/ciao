
#! Requried Headers
headers: 'User-Agent': 'Ciao/Client 1.0'

#! Log in
headers: 'Cookie': config['tester@test.com']

#> Register new user
host: 'www.yahoo.co.uk'
path: '/'
method: 'GET'
headers:
  'Accept': 'application/json'
  'Content-Type': 'application/json'
body: 
  email: 'example@example.com'
  password: 'mySecretPass'

#? Status: 301
response.statusCode.should.equal 301

#? Response should redirect to http://uk.yahoo.com/foo
response.headers.should.have.property 'location', 'http://uk.yahoo.com/'

#? Should return a server name
response.headers.should.have.property 'server', 'YTS/1.20.10'