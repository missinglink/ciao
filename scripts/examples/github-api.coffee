
#! Requried Headers
headers: 'User-Agent': 'Ciao/Client 1.0'

#> Github API call for node.js README
port: 443
protocol: 'https:'
host: 'api.github.com'
path: '/repos/joyent/node/readme'
headers: 'Accept': 'application/json'

#? Readme is available on Github
response.statusCode.should.equal 200
response.should.have.header 'server', 'GitHub.com'

#? Should be what we are looking for...
json.sha.should.match /^[a-z0-9]{40}/
json.should.include
  type: 'file'
  path: 'README.md'
  url: 'https://api.github.com/repos/joyent/node/contents/README.md?ref=master'
  html_url: 'https://github.com/joyent/node/blob/master/README.md'
  git_url: 'https://api.github.com/repos/joyent/node/git/blobs/' + json.sha