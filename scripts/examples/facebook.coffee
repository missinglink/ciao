
#> Facebook graph API call
port: 443
protocol: 'https:'
host: 'graph.facebook.com'
path: '/peter.johnson.nz'

#? Resource is available
response.statusCode.should.equal 200

#? Should be a graph user object
json.should.eql {
  id: "1617360746",
  name: "Peter Johnson",
  first_name: "Peter",
  last_name: "Johnson",
  username: "peter.johnson.nz",
  gender: "male",
  locale: "en_GB"
}