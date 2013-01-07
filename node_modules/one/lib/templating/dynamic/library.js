var juxt         = require('functools').juxt.async,

    logging      = require('../../logging'),

    env          = require('../env'),
    version      = require('../version'),

    templates    = require('./templates'),

    oneJSPath    = require('./path'),
    oneJSConsole = require('./console'),
    oneJSProcess = require('./process');

function library(options, callback){

  logging.trace('Rendering library...');

  var view = {
    debug          : options.debug,
    version        : version,
    versions       : '{}',
    env            : env(options),
    sandbox_console : options.sandboxConsole,
    include_process : options.includeProcess
  };

  juxt({ 'path': oneJSPath, 'process': oneJSProcess, 'console': oneJSConsole })(options, function(error, partials){

    if(error){
      callback(error);
      return;
    }

    templates.library(view, partials, callback);

  });

}

module.exports = library;
