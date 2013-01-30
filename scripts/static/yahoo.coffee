
#! Requried Headers
headers: 'User-Agent': 'Ciao/Client 1.0'

#> Register new user
host: 'www.yahoo.co.uk'
path: '/'
method: 'GET'

#? Status: 301
response.statusCode.should.equal 301

#? Response should redirect to http://uk.yahoo.com/foo
response.should.have.header 'location', 'http://uk.yahoo.com/'

#? Should return a server name
response.should.have.header 'server', 'YTS/1.20.10'