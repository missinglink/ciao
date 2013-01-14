
# Token Auth - Invalid Params
host: 'stage.bizzby.me'
path: '/auth/token'
method: 'POST'
headers:
  'Accept': 'application/json'

# Status: 400 Bad Request
response.statusCode.should.equal 400

# Should set a cookie
response.should.have.header 'Set-Cookie'

# Error message is provided
json = JSON.parse( response.body )
json.body.error.should.eql "You must provide both 'service' and 'token' params"