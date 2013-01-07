{{ treeName }}.pkg({{#hasParent}}{{ parentIds }}, {{/hasParent}}function(parents){

  return {
    'id':{{ id }},
    'name':'{{ name }}',
    'main':undefined,
    'mainModuleId':'{{ main }}',
    'modules':[],
    'parents':parents
  };

});

{{{modules}}}
