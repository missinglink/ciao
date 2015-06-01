var resolveBin = require('resolve-bin')


/**
 * Find the path to the coffee-script binary
 */
var _csPath = null;
var _getCsPath = function(cb){

    if(_csPath){
        return cb(null, _csPath);
    }

    resolveBin('coffee-script', {executable: 'coffee'}, function(err, bin){
        if(err){
            return cb(err);
        }

        _csPath = bin;

        return cb(null, _csPath);
    })
}

exports.csPath = _getCsPath;