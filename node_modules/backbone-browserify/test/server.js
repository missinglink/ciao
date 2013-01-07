// node test/server.js
// visit localhost:9000 in browser

var express = require('express'),
    browserify = require('browserify');
var app = express.createServer();

app.set('views', __dirname + '/');
app.set('view options', {
    layout: false
});

app.use(express.bodyParser());
app.use(express.methodOverride());
app.use(app.router);
app.use(browserify({
    require : { 
        jQuery: 'jquery-browserify', 
        backbone: __dirname + '/../lib/backbone-browserify.js' 
    }
}));

app.get('/', function(req, res) {
    res.render('index.html');
});

app.listen(9000);