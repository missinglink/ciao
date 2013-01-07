var kick = require('highkick'),
    rimraf = require('rimraf'),
    fs = require('fs');

function clean(callback){
  rimraf('tmp', function(error){
    
    if(error) throw error;

    fs.unlink('.genpkg', callback);

  });
}

function run(callback){
  kick({ 'ordered':true, module:require('./tests'), name:'genpkg' }, callback);
}



clean(function(){

  fs.mkdir('tmp', 0755, function(error){
    
    if(error) throw error;

    run(function(error){
      if(error) throw error;

      clean();

    });

  });

})
