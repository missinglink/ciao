
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

# Status: 400 Bad Request
response.statusCode.should.equal 401

# Error message is provided
json = JSON.parse( response.body )
json.body.error.should.eql "The 'service' you specified is not supported"