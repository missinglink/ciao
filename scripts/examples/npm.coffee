
#> Get package details from the npm registry
host: 'registry.npmjs.org'
path: '/ciao/latest'
headers: 'Accept': 'application/json'

#? Should have preferGlobal set to true
json.preferGlobal.should.be.true