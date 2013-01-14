
# Token Auth - Invalid Params
host: 'stage.bizzby.me'
path: '/auth/token'
method: 'POST'
headers:
  'Accept': 'application/json'
  'Content-Type': 'application/json'
body: 
  service: 'facebook'
  token: '43423'

# Bad Request
response.statusCode.should.equal 401

# Should set a cookie
response.should.have.header 'Set-Cookie'

# Error message is provided
JSON.parse( response.body ).body.error.should.eql "Your facebook account must share the email address"