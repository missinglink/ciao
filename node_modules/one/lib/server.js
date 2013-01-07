var http = require('http'),
    templating = require('./templating'),
    logging = require('./logging');

function firebug(options, req, res){
  res.writeHead(200, {'Content-Type': 'text/html'});

  templating.render({ 'template':'firebug.html', 'view':{ 'content':options.content, 'pkgname':templating.makeVariableName(options.pkg.name), 'modname':options.pkg.modules[0].id } }, function(error, html){
    if(error) throw error;
    res.end(html);
  });
}

function raw(options, req, res){
  res.end(options.content);
}

function start(options){
  logging.info('Server starts on %s:%d', options.host, options.port);
  http.createServer(function(req, res){
    if(req.url == '/raw' || req.url == '/raw/'){
      raw(options, req, res);
    } else {
      firebug(options, req, res);
    }
  }).listen(options.port, options.host);
}

module.exports = {
  'start':start
}
