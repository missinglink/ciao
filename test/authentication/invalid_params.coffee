
# Token Auth
host: 'stage.bizzby.me'
path: '/auth/token'
method: 'POST'
headers: 'Accept': 'application/json'

# Bad Request
response.statusCode.should.equal 400

# Should set a cookie
response.should.have.header 'Set-Cookie'

# Error message is provided
JSON.parse( response.body ).body.error.should.eql "You must provide both 'service' and 'token' params"