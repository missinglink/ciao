var logging   = require('../../logging'),

    env       = require('../env'),

    templates = require('./templates'),

    version   = require('../version');

module.exports = function(options, callback){

  logging.trace('Rendering process...');

  var view = {
    'env': env(options),
    'debug': options.debug,
    'version': version,
    'versions': JSON.stringify({ one: version })
  };

  templates.process(view, callback);
};
