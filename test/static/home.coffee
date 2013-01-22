
# Home Page is Up & Running
host: 'stage.bizzby.me'
path: '/'
method: 'GET'
headers:
  'Cookie': config.cookies.foo

# Bad Request
response.statusCode.should.equal 200

# Should set a cookie
response.should.have.header 'Set-Cookie'

# Should contain the company name
response.body.should.include 'Bizzby'