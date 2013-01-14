
# Home Page is Up & Running
host: 'stage.bizzby.me'
path: '/'
method: 'GET'

# Bad Request
response.statusCode.should.equal 200

# Should set a cookie
response.should.have.header 'Set-Cookie'