node = (function(){

  var exports = {};

  exports.path = (function(exports){ 
    {{>path}}

    return exports;
  })({});

  {{#process}}
  exports.process = (function(exports){
    {{>process}}

    return exports;
  })({});
  {{/process}}

  return exports;

})();
