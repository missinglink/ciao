var {{ name }} = (function(undefined){

  var exports = {}, module = { 'exports': exports };

  {{{ content }}}

  return module.exports;

})();

if(typeof module != 'undefined' && module.exports){
  module.exports = {{ name }};
};
