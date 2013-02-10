#> Wikipedia home page
host: 'en.wikipedia.org'
path: '/wiki/Main_Page'

#? Check headers are correctly rendered
$('span.mw-headline').first().text().should.eql "From today's featured article"
$('span.mw-headline').eq(1).text().should.eql "Did you know..."
$('span.mw-headline').eq(2).text().should.eql "In the news"
$('span.mw-headline').eq(3).text().should.eql "On this day..."
$('span.mw-headline').last().text().should.eql "Wikipedia languages"