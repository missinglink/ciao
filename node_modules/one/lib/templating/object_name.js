module.exports = function objectName(str){

  return str.toLowerCase().replace(/[^a-zA-Z0-9]+/g,' ').replace(/^[\d\s]+/g,'').split(' ').reduce(function(a,b){
    return a + b.charAt(0).toUpperCase() + b.slice(1).toLowerCase();
  });

};
