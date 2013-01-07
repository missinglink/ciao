var logging        = require('../../logging'),
    objectName     = require('../object_name'),
    templates      = require('./templates');

function plain(pkg, options, callback){
  logging.info('Rendering %s', pkg.name);

  templates.wrapper({ 'name': objectName(pkg.name), 'content': pkg.modules[0].content }, callback);
}

module.exports = plain;
