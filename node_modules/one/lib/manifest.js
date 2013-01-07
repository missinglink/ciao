var boxcars = require('boxcars'),
    path    = require('path'),
    logging = require('./logging');

function find(packageName, workingdir, callback){
  logging.debug('Searching for the manifest file of package "%s" under "%s"', packageName, workingdir);

  var filename = path.join(workingdir, 'node_modules', packageName, '/package.json');

  path.exists(filename, function(exists){
    if(exists){
      callback(undefined, filename);
      return;
    }

    var up = path.join(workingdir, '../');

    if( path.join(process.cwd(), workingdir) == '/'){
      logging.error('Failed to find package "%s"', packageName);
      callback(new Error('Failed to find package "'+packageName+'"'));
      return;
    }

    path.exists( up, function(exists){

      if(!exists){
        logging.error('Failed to find package "%s"', packageName);
        callback(new Error('Failed to find package "'+packageName+'"'));
        return;
      }

      find(packageName, up, callback);

    });

  });
}

function fix(manifest){

  var lib  = manifest.directories && manifest.directories.lib,
      main = manifest.main;

  if( lib && main && ( main.substring(0, lib.length) != lib && ( './' + main ).substring(0, lib.length) != lib ) ){
    delete manifest.directories.lib;
  }

  return manifest;

}

function read(filename, callback){
  logging.debug('Reading the manifest @ "%s"', filename);

  var manifest;

  boxcars(filename)(function(error, bf){

    if(error){
      logging.error('Failed to read the file "%s"', filename);
      callback(error);
      return;
    }

    logging.debug('Parsing the manifest @ "%s"', filename);

    try {

      manifest = JSON.parse(bf);
      logging.trace('Manifest file "%s" loaded and parsed successfully.', filename);

    } catch(exc) {

      logging.error('Failed to parse the manifest @ "%s"', filename);
      error = exc;

    }

    callback(error, fix(manifest));

  });

}

module.exports = read;
module.exports.find = find;
