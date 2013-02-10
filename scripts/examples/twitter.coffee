#> Twitter home page
protocol: 'https:'
port: 443
host: 'twitter.com'

#? Login form
$('div.front-signin input#signin-email').length.should.eql 1
$('div.front-signin input#signin-password').length.should.eql 1
$('div.front-signin button[type="submit"]').length.should.eql 1