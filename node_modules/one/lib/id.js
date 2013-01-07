module.exports = function genId(){
  var serial = 0;
  return function id(){
    return ++serial;
  };
};
