# Ciao - Functional testing made easy

Ciao is a simple framework for testing HTTP(s) requests and generating API documentation.

## Anatomy of a ciao script:

Ciao scripts are written in coffee-script, however it's important to note that they are interpreted, not executed.

### Sample script:

```
#! Requried Headers
headers: 'User-Agent': 'Ciao/Client 1.0'

#> Register new user
host: 'www.google.co.uk'
path: '/'
method: 'GET'

#? Status: 200 OK
response.statusCode.should.equal 200

#? Response.body should contain company name
response.body.should.include 'Google'
```

## Interpreter directives

Ciao currently supports 3 interpreter directives:

`#!` defines properties to include in every request

`#>` defines a request

`#?` defines an assertion (or test)