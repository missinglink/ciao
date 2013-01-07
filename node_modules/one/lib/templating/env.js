function env(options){
  var result, key;

  if(options.debug){
    result = {};
    for(key in process.env){
      result[ key ] = process.env[ key ].replace(/"/g, '\'');
    }
  }

  return JSON.stringify(result);
}

module.exports = env;
