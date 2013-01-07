
lib = (function(exports){

  exports.path = (function(exports){
    {{>path}}

    return exports;
  }({}));

  {{#include_process}}

  global.process = exports.process = (function(exports){
    {{>process}}

    return exports;
  }({}));

  {{/include_process}}

  {{#sandbox_console}}
    global.console = exports.console = (function(exports){
      {{>console}}
      return exports;
    }({}));
  {{/sandbox_console}}

  return exports;

}({}));
