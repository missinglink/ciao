var path     = require('path'),
    readFile = require('fs').readFile,

    logging  = require('./logging');

function filename(dir){
  return path.join(dir, '.npmignore');
}

function npmignore(dir, callback){
  readFile( filename(dir), function(error, bf){
    if(error){
      callback(error);
      return;
    }

    var lines = bf.toString()
          .split('\n')
          .map(function(el){
            return el.replace(/\s/g, '');
          })
          .filter(function(el){
            return el.length;
          });

    logging.debug('%s has been loaded and parsed.', filename(dir));

    callback(undefined, lines);

  });
}

module.exports = npmignore;
