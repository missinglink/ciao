
# Token Auth - Invalid Token
host: 'stage.bizzby.me'
path: '/auth/token'
method: 'POST'
headers:
  'Accept': 'application/json'
  'Content-Type': 'application/json'
body: 
  service: 'facebook'
  token: '43423'

# Status: 401 Unauthorized
response.statusCode.should.equal 400

# Error message is provided
json = JSON.parse( response.body )
json.body.error.should.eql "Your facebook account must share the email address"