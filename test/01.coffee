
# Token Auth
host: 'stage.bizzby.me'
path: '/auth/token'
method: 'POST'
headers: 'Accept': 'application/json'

# Bad Request
response.statusCode.should.equal 400

# Error message is provided
JSON.parse( response.body ).body.error.should.eql "You must provide both 'service' and 'token' params"
JSON.parse( response.body ).body.error.should.eql "You must provide both 'service' and 'token' params"