var functools = require('functools'),
    path = require('path'),
    fs = require('fs'),
    puts = require('util').puts;

var middleware = {
  'filter':[],
  'map':[read],
  'reduce':undefined
};

var chain = functools.compose.async(findFiles,
  includeDirectories,
  flatten,
  filter,
  map,
  reduce);

function map(files, callback){
  (function(i,error, nfiles){
    nfiles && ( files = nfiles );

    if(error || i>=middleware.map.length){
      return callback(error, files);
    }
  
    var next = arguments.callee.bind(undefined, i+1);

    functools.map.async(middleware.map[i], files, arguments.callee.bind(undefined, i+1));

  })(0);
}

function filter(files, callback){
  (function(i,nfiles){
    nfiles && ( files = nfiles );

    if(i>=middleware.filter.length){
      return callback(undefined, files);
    }
  
    var next = arguments.callee.bind(undefined, i+1);

    functools.filter.async(middleware.filter[i], files, arguments.callee.bind(undefined, i+1));

  })(0);
}

function flatten(list,callback){
  var clone = list.slice(0);
  clone.splice(0,0,[]);

  functools.reduce.async(function(a,b,callback){
    if(Array.isArray(b)){
      flatten(b,function(undefined,b){
        callback(null, a.concat(b));
      });
    } else {
      a.push(b);
      callback(null,a)
    }   

  },clone,callback); 
}

function findFiles(paths,callback){
  var files = [], error;
  (function _(i){
    if(i>=paths.length || error){
      callback(error, files); 
      return;
    }

    var next = _.bind(null,i+1),
        uri = paths[i];

    path.exists(uri, function(exists){

      if(!exists){
        next();
        return;
      }

      fs.stat(uri, function(error, stat){
        if(error){
          callback(error);
          return;
        }

        if(!stat.isDirectory()){
          files.push(uri);
          next();
          return;
        }

        fs.readdir(uri,function(error, list){
          if(error){
            callback(error);
            return;
          }

          Array.prototype.push.apply(files, list.map(function(el){
            return path.join(uri,el);
          }));

          next();
        });
      });
    });

  })(0);
}

function includeDirectories(files,callback){
  (function(i){
    if(i>=files.length){
      return callback(null, files);
    }

    var el = files[i],
        next = arguments.callee.bind(undefined, i+1);

    fs.stat(el, function(error, stat){
      if(error){
        return callback(error);
      }
      if(stat.isDirectory()){
        findFiles([el], function(error, _list){
          includeDirectories(_list, function(error, list){
            files[i] = list;
            next();
          });
        }); 
      } else {
        next();
      }
    }); 
       
  })(0);
}

function read(filename,callback){
  fs.readFile(filename, function(error, data){
    if(error){
      return callback(error);
    }
    callback(error, data.toString());
  });
}

function reduce(files, callback){
  functools.reduce.async(middleware.reduce || function(x,y,cb){
    cb(undefined, x + '\n\n' + y);
  }, files, callback);
}

function run(workingDir, middlewareOptions,callback){
  if(middlewareOptions){
    middlewareOptions.reduce && ( middleware.reduce = middlewareOptions.reduce );
    middlewareOptions.map && middleware.map.push(middlewareOptions.map);
    middlewareOptions.filter && middleware.filter.push(middlewareOptions.filter); 
  }

  chain(workingDir || './', callback || function(error, result){
    if(error){
      console.log('Error Occured:'+error.message);
      console.log(error.stack);
    } else {
      puts(result);
    }
  });

}

!module.parent && run();

module.exports = {
  'chain':chain,
  'filter':filter,
  'findFiles':findFiles,
  'flatten':flatten,
  'includeDirectories':includeDirectories,
  'map':map,
  'middleware':middleware,
  'read':read,
  'reduce':reduce,
  'run':run
};
