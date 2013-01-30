
#> Github page for missinglink/ciao
port: 443
protocol: 'https:'
host: 'github.com'
path: '/missinglink/ciao'

#? Repo is private
response.statusCode.should.equal 404

#? Should be github
response.headers.should.have.property 'server', 'GitHub.com'