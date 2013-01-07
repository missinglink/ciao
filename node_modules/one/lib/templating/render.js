var mustache  = require('mustache');

function render(buffer, views, partials, callback){

  var output;

  try {
    output = mustache.to_html(buffer, views, partials);
  } catch (mustacheError) {
    callback(mustacheError);
    return;
  }

  callback(undefined, output);

}

module.exports = render;
