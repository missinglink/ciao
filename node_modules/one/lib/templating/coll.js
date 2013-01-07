var boxcars = require("boxcars"),

    config = require("../config"),

    render = require('./render');

function templateName(filename){
  return filename
    .replace(/\.js$/, '')
    .replace(/^\w+\//, '');
}

function template(files, name){

  var args     = Array.prototype.slice.call(arguments),

      views    = args.length > 3 ? args[2] : undefined,
      partials = args.length > 4 ? args[3] : undefined,

      callback = args[ args.length - 1 ];

  files(function(error, buffers){

    if(error){
      callback(error);
      return;
    }

    if( !buffers.hasOwnProperty( name ) ){
      callback(new Error('Unknown name: "' + name + '"'));
      return;
    }

    render(buffers[name], views, partials, callback);

  });

}

function coll(){
  var param = {},
      files = undefined;

  var i = arguments.length,
      name, filename;

  while( i --> 0 ){

    filename = arguments[i];

    name = templateName(filename);

    param[ name ] = config.TEMPLATES_DIR + '/' + filename;

  }

  files = boxcars(param);

  for(key in param){

    files [ key ] = template.bind(undefined, files, key);

  }

  return files;
}

module.exports = coll;
