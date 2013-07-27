
#> Github API call for node.js README
port: 443
protocol: 'https:'
host: 'api.github.com'
path: '/repos/joyent/node/readme'
headers: 'Accept': 'application/json'

#? check 1
should.exist json._links

#? check2
json._links.foo.should.equal 'bar'