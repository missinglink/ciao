function log(bf){
  return function(){
    bf.write( Array.prototype.join.call(arguments, ' ') + '\n' );
  };
}

exports.log   =
exports.info  =
exports.trace =
exports.dir   = log(global.process.stdout);

exports.warn  =
exports.error = log(global.process.stderr);

exports.timeStart =
exports.timeEnd   =
exports.assert    = function(){};

