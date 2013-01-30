
#> Github page for missinglink/ciao
port: 443
protocol: 'https:'
host: 'github.com'
path: '/missinglink/ciao'

#? Repo is private
response.statusCode.should.equal 404

#? Should be github
response.should.have.header 'server', 'GitHub.com'