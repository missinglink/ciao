
#> Github page for missinglink/ciao
port: 443
protocol: 'https:'
host: 'github.com'
path: '/missinglink/ciao'

#? Repo is public
response.statusCode.should.equal 200

#? Should be github
response.should.have.header 'server', 'GitHub.com'