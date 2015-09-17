# Github API call for node.js README

*Generated: Wed Jan 30 2013 23:28:03 GMT+0000 (GMT)*
## Request
```javascript
{
  "protocol": "https:",
  "host": "api.github.com",
  "method": "GET",
  "port": 443,
  "path": "/repos/joyent/node/readme",
  "headers": {
    "User-Agent": "Ciao/Client 1.0",
    "Accept": "application/json"
  },
  "defaultPort": 443
}
```

## Response
```javascript
Status: 200
{
  "server": "GitHub.com",
  "date": "Wed, 30 Jan 2013 23:27:59 GMT",
  "content-type": "application/json; charset=utf-8",
  "connection": "close",
  "status": "200 OK",
  "content-length": "2595",
  "vary": "Accept",
  "x-ratelimit-limit": "60",
  "x-content-type-options": "nosniff",
  "last-modified": "Wed, 30 Jan 2013 17:04:30 GMT",
  "etag": "\"c5e90c87596803c53da212cfb3f63848\"",
  "cache-control": "public, max-age=60, s-maxage=60",
  "x-ratelimit-remaining": "7",
  "x-github-media-type": "github.beta"
}
```
```javascript
{
  "url": "https://api.github.com/repos/joyent/node/contents/README.md",
  "type": "file",
  "sha": "988305facd99bcb141492c90a84a17bb2402fc1a",
  "path": "README.md",
  "git_url": "https://api.github.com/repos/joyent/node/git/blobs/988305facd99bcb141492c90a84a17bb2402fc1a",
  "html_url": "https://github.com/joyent/node/blob/master/README.md",
  "_links": {
    "self": "https://api.github.com/repos/joyent/node/contents/README.md",
    "html": "https://github.com/joyent/node/blob/master/README.md",
    "git": "https://api.github.com/repos/joyent/node/git/blobs/988305facd99bcb141492c90a84a17bb2402fc1a"
  },
  "size": 1426,
  "encoding": "base64",
  "content": "RXZlbnRlZCBJL08gZm9yIFY4IGphdmFzY3JpcHQuIFshW0J1aWxkIFN0YXR1\nc10oaHR0cHM6Ly9zZWN1cmUudHJhdmlzLWNpLm9yZy9qb3llbnQvbm9kZS5w\nbmcpXShodHRwOi8vdHJhdmlzLWNpLm9yZy9qb3llbnQvbm9kZSkKPT09Cgoj\nIyMgVG8gYnVpbGQ6CgpQcmVyZXF1aXNpdGVzIChVbml4IG9ubHkpOgoKICAg\nICogUHl0aG9uIDIuNiBvciAyLjcKICAgICogR05VIE1ha2UgMy44MSBvciBu\nZXdlcgogICAgKiBsaWJleGVjaW5mbyAoRnJlZUJTRCBhbmQgT3BlbkJTRCBv\nbmx5KQoKVW5peC9NYWNpbnRvc2g6CgogICAgLi9jb25maWd1cmUKICAgIG1h\na2UKICAgIG1ha2UgaW5zdGFsbAoKV2luZG93czoKCiAgICB2Y2J1aWxkLmJh\ndAoKIyMjIFRvIHJ1biB0aGUgdGVzdHM6CgpVbml4L01hY2ludG9zaDoKCiAg\nICBtYWtlIHRlc3QKCldpbmRvd3M6CgogICAgdmNidWlsZC5iYXQgdGVzdAoK\nIyMjIFRvIGJ1aWxkIHRoZSBkb2N1bWVudGF0aW9uOgoKICAgIG1ha2UgZG9j\nCgojIyMgVG8gcmVhZCB0aGUgZG9jdW1lbnRhdGlvbjoKCiAgICBtYW4gZG9j\nL25vZGUuMQoKUmVzb3VyY2VzIGZvciBOZXdjb21lcnMKLS0tCiAgLSBbVGhl\nIFdpa2ldKGh0dHBzOi8vZ2l0aHViLmNvbS9qb3llbnQvbm9kZS93aWtpKQog\nIC0gW25vZGVqcy5vcmddKGh0dHA6Ly9ub2RlanMub3JnLykKICAtIFtob3cg\ndG8gaW5zdGFsbCBub2RlLmpzIGFuZCBucG0gKG5vZGUgcGFja2FnZSBtYW5h\nZ2VyKV0oaHR0cDovL2pveWV1ci5jb20vMjAxMC8xMi8xMC9pbnN0YWxsaW5n\nLW5vZGUtYW5kLW5wbS8pCiAgLSBbbGlzdCBvZiBtb2R1bGVzXShodHRwczov\nL2dpdGh1Yi5jb20vam95ZW50L25vZGUvd2lraS9tb2R1bGVzKQogIC0gW3Nl\nYXJjaGluZyB0aGUgbnBtIHJlZ2lzdHJ5XShodHRwOi8vc2VhcmNoLm5wbWpz\nLm9yZy8pCiAgLSBbbGlzdCBvZiBjb21wYW5pZXMgYW5kIHByb2plY3RzIHVz\naW5nIG5vZGVdKGh0dHBzOi8vZ2l0aHViLmNvbS9qb3llbnQvbm9kZS93aWtp\nL1Byb2plY3RzLC1BcHBsaWNhdGlvbnMsLWFuZC1Db21wYW5pZXMtVXNpbmct\nTm9kZSkKICAtIFtub2RlLmpzIG1haWxpbmcgbGlzdF0oaHR0cDovL2dyb3Vw\ncy5nb29nbGUuY29tL2dyb3VwL25vZGVqcykKICAtIGlyYyBjaGF0cm9vbSwg\nWyNub2RlLmpzIG9uIGZyZWVub2RlLm5ldF0oaHR0cDovL3dlYmNoYXQuZnJl\nZW5vZGUubmV0P2NoYW5uZWxzPW5vZGUuanMmdWlvPWQ0KQogIC0gW2NvbW11\nbml0eV0oaHR0cHM6Ly9naXRodWIuY29tL2pveWVudC9ub2RlL3dpa2kvQ29t\nbXVuaXR5KQogIC0gW2NvbnRyaWJ1dGluZ10oaHR0cHM6Ly9naXRodWIuY29t\nL2pveWVudC9ub2RlL3dpa2kvQ29udHJpYnV0aW5nKQogIC0gW2JpZyBsaXN0\nIG9mIGFsbCB0aGUgaGVscGZ1bCB3aWtpIHBhZ2VzXShodHRwczovL2dpdGh1\nYi5jb20vam95ZW50L25vZGUvd2lraS9fcGFnZXMpCg==\n",
  "name": "README.md"
}
```

## Tests

### ✓ Readme is available on Github
```javascript
response.statusCode.should.equal 200
response.should.have.header 'server', 'GitHub.com'
```

### ✓ Should be what we are looking for...
```javascript
json.sha.should.match /^[a-z0-9]{40}/
json.should.containEql
  type: 'file'
  path: 'README.md'
  url: 'https://api.github.com/repos/joyent/node/contents/README.md'
  html_url: 'https://github.com/joyent/node/blob/master/README.md'
  git_url: 'https://api.github.com/repos/joyent/node/git/blobs/' + json.sha
```

