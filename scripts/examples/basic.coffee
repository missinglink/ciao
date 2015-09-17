#> Check Google is still running
host: 'www.google.co.uk'

#? Should have company name
response.body.should.containEql 'Google'