
# Token Auth
host: 'stage.bizzby.me'
path: '/auth/token'
method: 'POST'
headers: 'Accept': 'application/json'

# Bad Request
response.statusCode.should.equal 400

# Should set a cookie
response.should.have.header 'Set-Cookie'

# Foo header present
response.should.have.header 'Foo'