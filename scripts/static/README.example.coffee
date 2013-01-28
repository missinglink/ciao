
#! Requried Headers
headers: 'User-Agent': 'Ciao/Client 1.0'

#> Check the home page is up!
host: 'www.google.co.uk'
path: '/'
method: 'GET'

#? Status: 200 OK
response.statusCode.should.equal 200

#? Response.body should contain company name
response.body.should.include 'Google'