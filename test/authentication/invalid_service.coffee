
# Token Auth - Invalid Service
host: 'stage.bizzby.me'
path: '/auth/token'
method: 'POST'
headers:
  'Accept': 'application/json'
  'Content-Type': 'application/json'
body: 
  service: 'invalid_service'
  token: '43423'

# Bad Request
response.statusCode.should.equal 400

# Error message is provided
JSON.parse( response.body ).body.error.should.eql "The 'service' you specified is not supported"