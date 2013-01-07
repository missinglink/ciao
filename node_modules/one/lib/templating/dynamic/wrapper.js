var logging   = require('../../logging'),
    library   = require('./library'),
    templates = require('./templates');

function ties(options){

  if(!options.tie){
    return undefined;
  }

  var output = '{', key,
      i      = options.tie.length,
      comma  = '',
      tie;

  while( i -- ){
    tie = options.tie[i];
    output += comma + '"'+ ( tie.pkg || tie.module ) + '": ' + ( tie.obj || tie.to );
    comma = ', ';
  }

  output += '}';

  return output;
};

function wrapper(treeName, packages, options, callback){
  logging.trace('Rendering wrapper template...');

  var partials = {},
      views     = {
        'name'            : treeName,
        'debug'           : options.debug,
        'ties'            : ties(options),
        'sandbox_console' : options.sandboxConsole,
        'include_process' : options.includeProcess
      };

  library(options, function(error, renderedLibrary){

    if(error){
      callback(error);
      return;
    }

    views.packages = packages;
    views.library  = renderedLibrary;

    templates.wrapper(views, callback);

  });
}

module.exports = wrapper;
