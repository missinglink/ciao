{{ treeName }}.module({{ parentId }}, function(/* parent */){

  return {
    'id': '{{ id }}',
    'pkg': arguments[0],
    'wrapper': function(module, exports, global, Buffer,{{#sandbox_console}} console, {{/sandbox_console}} {{#include_process}}process,{{/include_process}} require, undefined){
      {{{content}}}
    }
  };

});
