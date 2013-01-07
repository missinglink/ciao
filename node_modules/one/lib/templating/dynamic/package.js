var map         = require('functools').map.async,

    logging     = require('../../logging'),

    templates   = require('./templates'),

    oneJSModule = require('./module');

function sort(a, b){
  return a.filename.localeCompare(b.filename);
}

function parentIds(pkg){
  return pkg.parents.map(function(el){ return el.id; }).join(', ');
}

module.exports = function oneJSPackage(treeName, options, pkg, callback){

  logging.debug('Building package "'+pkg.name+'"');

  var modules = pkg.modules.sort(sort),
      view = {
        'treeName'  : treeName,
        'hasParent' : pkg.parents.length > 0,
        'parentIds' : parentIds(pkg),
        'id'        : pkg.id,
        'main'      : pkg.main && pkg.main.id,
        'name'      : pkg.name,
        'wd'        : pkg.wd
      };

  map( oneJSModule.bind(undefined, pkg, treeName, options), modules, function(error, modules){

    if(error) {
      callback(error);
      return;
    }

    view.modules = modules.join('\n\n');

    templates['package'](view, callback);

  });

};
