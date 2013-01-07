[ define, test, import ] = require 'hypertest'

define 'auth.login'

  method: 'POST'
  uri: 'http://www.google.com/login'
  form: 
    email: 'test@example.com'
    password: '1234567890'

test 'auth.login', (response) ->

  response.code.should.equal 200