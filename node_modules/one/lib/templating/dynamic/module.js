var logging   = require('../../logging'),
    templates = require('./templates');

module.exports = function oneJSModule(pkg, treeName, options, module, callback){

  logging.debug('Building module "'+module.id+'"');

  var view = {
    'treeName'        : treeName,
    'parentId'        : pkg.id,
    'id'              : module.id,
    'sandbox_console' : options.sandboxConsole,
    'include_process' : options.includeProcess,
    'content'         : module.content
  };

  templates.module(view, callback);

};
