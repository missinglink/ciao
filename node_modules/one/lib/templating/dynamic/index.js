var readFile       = require('fs').readFile,
    map            = require('functools').map.async,

    logging        = require('../../logging'),
    flattenPkgTree = require('../flatten'),
    objectName     = require('../object_name'),

    npmpackage     = require('./package'),
    wrapper        = require('./wrapper'),

    templates      = require('./templates');

function dynamic(pkg, options, callback){

  logging.info('Rendering %s', pkg.name);

  var treeName = objectName(pkg.name),
      tree     = flattenPkgTree(pkg).sort(sort);

  options.includeProcess = !options.noprocess;

  map( npmpackage.bind(undefined, treeName, options), tree, function(error, packages){

    if(error){
      callback(error);
      return;
    }

    logging.info('All packages has been built. Rendering the output now...');

    wrapper(treeName, packages.join('\n\n\n\n'), options, callback);

  });

}

function sort(a, b){
  return a.name.localeCompare(b.name);
}

module.exports = dynamic;
module.exports.flattenPkgTree = flattenPkgTree;
