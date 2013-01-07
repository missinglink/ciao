
# Home Page
uri: '/'
method: 'GET'

# Page is up
response.statusCode.should.equal 201

# Required text is present
response.body.should.include "I'm feeling lucky!"