var request = require('request'),
    logging = require('./logging'),
    fs = require('fs'),
    path = require('path'),
    mkdirp = require('mkdirp'),
    index = require('./index');

function fetch(uri, callback){
  logging.trace('fetching %s', uri);

  if(!/\w+\:\/\//.test(uri)){
    logging.trace('Reading '+uri);
    fs.readFile(uri, callback);
    return;
  }

  logging.trace('sending request to '+uri);
  request(uri, function(error, response, body){
    if(error){
      return callback(error);
    }

    if(response.statusCode == 200){
      callback(error, body);
    }

  });
}

function manifest(options){
  return {
    'name':path.basename(options.uri, '.js'),
    'author':options.author,
    'description':options.description,
    'version':options.version,
    'uri':options.uri,
    'main':path.basename(options.uri,'.js')
  };
}

function pkg(options, callback){
  logging.trace('generating package for '+options.uri);
  fetch(options.uri, function(error, content){
    if(error){
      return callback(error);
    }

    callback(undefined, {
      'uri':options.uri,
      'manifest':manifest(options),
      'content':content
    });
  });
}

function save(options, callback){
  var manifestTarget = path.join(options.target, '/package.json'),
      moduleTarget = path.join(options.target, options.manifest.main) + '.js',
      dirtree = path.dirname(moduleTarget);

  mkdirp(dirtree, 0755, function(dirtreeWriteError){

    if(dirtreeWriteError) return callback(dirtreeWriteError);

    fs.writeFile(manifestTarget, JSON.stringify(options.manifest), function(manifestWriteError) {
      if(manifestWriteError) {
        logging.error('Failed to save manifest "'+manifestTarget+'"');
        return callback(manifestWriteError);
      }

      logging.info('Manifest file "'+manifestTarget+'" was saved!');

      fs.writeFile(moduleTarget, options.content, function(moduleWriteError){
        if(moduleWriteError) {
          logging.error('Failed to save module "'+moduleTarget+'"');
          return callback(moduleWriteError);
        }

        index.update(options.manifest.name, { 'uri':options.uri, 'content':options.content, 'path':options.target }, function(indexUpdateError, updated){

          if(indexUpdateError) return callback(indexUpdateError);

          logging.info('Package "%s" saved successfully.', options.manifest.name);
          callback();

        });
      });
    });

  });

}

function update(pkgName, callback){

  logging.trace('Checking updates for '+pkgName);

  index.valueOf(pkgName, function(indexReadError, pkg){
    !indexReadError && !pkg && ( indexReadError = new Error('Invalid package name:'+pkgName) );
    if(indexReadError) return callback(indexReadError);

    fetch(pkg.uri, function(resourceReadError, content){
      if(resourceReadError) return callback(resourceReadError);
      
      if(index.encrypt(content) == pkg.sha1){
        logging.info('Package %s is already up to date', pkgName);
        return callback();
      }

      save({ 'target':pkg.path, 'content':content, 'uri':pkg.uri, 'manifest':manifest({ uri:pkg.uri }) }, function(saveError){
        if(saveError) return callback(saveError);
        
        callback(undefined, true);
      });

    });

  });
}

module.exports = {
  'fetch':fetch,
  'pkg':pkg,
  'manifest':manifest,
  'save':save,
  'update':update
};
