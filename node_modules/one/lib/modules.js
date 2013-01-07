var functools =  require('functools'),
    compose   = functools.compose,
    combiner  = require('combiner'),

    path      = require('path'),
    readFile  = require('fs').readFile,

    logging   = require('./logging');

var filters = [];

function filter(filenames, callback){
  var copy = filenames.slice(),
      i = -1, len = filters.length;

  while( ++i < len ){
    try {
      copy = copy.filter( filters[i] );
    } catch( exc ) {
    }
  }

  callback(undefined, copy);
}

function filterFilename(filename){
  return /\.js$/.test(filename);
}

function filterFilenames(filenames, callback){
  callback(undefined, filenames.filter(filterFilename));
}

function filterIgnoredModules(pkg){
  return function(filenames, callback){

    if(!pkg.ignore){
      callback(undefined, filenames);
      return;
    }

    var f = filenames.length,
        i, ignore, filename,
        ignored, result = [];

    while( f -- ){
      ignored = false;

      i = pkg.ignore.length;
      filename = filenames[f].substring(pkg.wd.length + ( pkg.wd.substring(pkg.wd.length-1) != '/' ? 1 : 0 ));

      while( i -- ){

        ignore = pkg.ignore[i];

        if( filename.substring( 0, ignore.length ) == ignore ){
          logging.debug('Module "%s" is ignored by the line "%s" at .npmignore', filename, ignore);
          ignored = true;
          break;
        }

      }

      !ignored && result.push( filenames[f] );

    }

    callback(undefined, result);

  };
}


function fixname(filename){
  var m = filename.match(/([^\/\.]+)\.js$/);
  return !m ? undefined : m[1];
}

function loadModule(filename, callback){

  logging.trace('Loading module "'+filename+'"');

  readFile(filename, function(error, bf){
    if(error) {
      callback(error);
      return;
    }

    var content = bf.toString(),
        name = fixname(filename);

    if(content.substring(0,2) == '#!'){
      content = content.replace(/\#\!.+\n/, '');
    }

    callback(undefined, {
      'name':name,
      'filename':filename,
      'path':filename,
      'content':content
    });

  });

};

function loadModules(pkg, base){

  return function(filenames, callback){
    logging.debug('Found '+filenames.length+' file(s) under the package "'+pkg.name+'"');
    var modules = [];

    (function next(i){
      if(i>=filenames.length){
        logging.debug('Loaded %d module(s) under the package "%s"',filenames.length,pkg.name);
        callback(undefined, modules);
        return;
      }

      loadModule(filenames[i], function(error, module){
        if(error){
          logging.error('Failed to load the module "'+filenames[i]+'"');
          callback(error);
          return;
        }

        //replacing '\' with '/' for Windows based systems
        module.filename = module.filename.replace(/\\/g,'/');
        module.filename = module.filename.replace(base+'/', '');
        module.filename.indexOf('/') > 0 && base != '.' && ( module.filename = module.filename.replace(base, '') );
        module.id = module.filename.replace(/\.js$/,'');


        if(!error) modules.push(module);

        next(i+1);

      });

    })(0);

  };
}

function modules(pkg, options, callback){
  logging.debug('Collect modules for the package "'+pkg.name+'"');

  var dirs = [],
      base = '',
      join = path.join.bind(undefined, pkg.wd),
      lib  = join('lib');

  if(pkg.dirs && pkg.dirs.lib){

    base = join(pkg.dirs.lib);
    dirs.push(base);

  } else if (pkg.manifest.main) {
    base = pkg.wd;

    dirs.indexOf(lib) == -1 && dirs.push(lib);
    dirs.push(join(pkg.manifest.main + ( /\.js$/.test(pkg.manifest.main) ? '' : '.js' )));

  } else {
    base = pkg.wd;
    dirs.push(join('index.js'));
    dirs.push(join('lib'));
  }

  logging.debug('The directories to search:', dirs);

  compose.async(combiner.findFiles,
    combiner.includeDirectories,
    combiner.flatten,
    filterFilenames,
    filterIgnoredModules(pkg),
    filter,
    loadModules(pkg, base))(dirs, callback);
}

module.exports = modules;
module.exports.filterFilename = filterFilename;
module.exports.loadModule = loadModule;
module.exports.loadModules = loadModules;
module.exports.fixname = fixname;
module.exports.filters = filters;
