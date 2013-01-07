var logging = require('./logging'),
    crypto = require('crypto'),
    fs = require('fs'),
    path = require('path');

var FILENAME = '.genpkg',
    writeLock = false;

function contents(callback){
  logging.trace('Reading .genpkg');
  path.exists(FILENAME, function(exists){

    if(!exists) return callback(undefined, {});

    fs.readFile(FILENAME, function(error, data){
      if(error) return callback(error);

      try { 
        callback(undefined, JSON.parse(data));
      } catch(parsingError){
        callback(parsingError);
      }
    });

  });
}

function encrypt(data){
  var hash = crypto.createHash('sha1');
  hash.update(data);
  return hash.digest('hex');
}

function update(packageName, value, callback){
  logging.trace('Updating .genpkg');
  
  var sha1 = encrypt(value.content);

  contents(function(error, records){
    if(error) return callback(error);
    
    if(!records[packageName] || sha1 != records[packageName].sha1){
      records[packageName] = { 'sha1':sha1, 'uri':value.uri, 'path':value.path };

      save(records, function(error){
        if(error) return callback(error);
        callback(undefined, true);
      });
    } else {
      callback();
    }
  });
}

function save(content, callback){
  logging.trace('Saving .genpkg');
  fs.writeFile(FILENAME, JSON.stringify(content), function(error){
    if(error) return callback(error);
    logging.info('%s has been saved. ',FILENAME);
    callback();
  });
}


function sha1Of(packageName, callback){
  logging.trace('Getting SHA1 of the package "%s"', packageName);
  valueOf(packageName, function(error, value){
    if(error) return callback(error);
    callback(undefined, value.sha1);
  });
}

function uriOf(packageName, callback){
  logging.trace('Getting URI of the package "%s"', packageName);
  valueOf(packageName, function(error, value){
    if(error) return callback(error);
    callback(undefined, value.uri);
  });
}

function valueOf(packageName, callback){
  logging.trace('Getting sha1 value of the package "%s"', packageName);
  contents(function(error, records){
    if(error) return callback(error);
    callback(undefined, records[packageName]);
  });
}


module.exports = {
  'contents':contents,
  'encrypt':encrypt,
  'update':update,
  'save':save,
  'sha1Of':sha1Of,
  'uriOf':uriOf,
  'valueOf':valueOf
}
