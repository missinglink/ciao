var pkg        = require('../package'),

    dynamic    = require("./dynamic"),
    statik     = require("./static"),
    plain      = require('./plain'),
    flatten    = require('./flatten'),
    objectName = require('./object_name');

function main(pkgOptions, buildOptions, callback){

  var layout = buildOptions.plain ? plain : dynamic;

  pkg(pkgOptions, buildOptions, function(error, loadedPkg){

    if(error){
      callback(error);
      return;
    }

    layout(loadedPkg, buildOptions, function(error, sourceCode){
      callback(error, sourceCode, pkg);
    });

  });

}

module.exports                = main;
module.exports.dynamic        = dynamic;
module.exports.statik         = statik;
module.exports.plain          = plain;
module.exports.flattenPkgTree = flatten;
module.exports.objectName     = objectName;
