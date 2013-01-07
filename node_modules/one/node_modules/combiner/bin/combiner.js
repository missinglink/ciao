#!/usr/bin/env node

var opts = require('opts'),
    puts = require('sys').puts;

var combiner;

try {
  combiner = require('../lib/combiner');
} catch(exc) {
  combiner = require('combiner');
}

var REV = '1.0';

var options; 
opts.parse((options = [
  { 
    'short':'v'
  , 'long':'version'
  , 'description':'Show version and exit'
  , 'callback':version
  }
, {
    'short':'map'
  , 'value':true
  , 'description':'Replace contents of the files with the results of calling a provided function.'
  }
, {
    'short':'reduce'
  , 'value':true
  , 'description':'Apply a function against an accumulator and each value of gathered list content as to reduce it to a single value.'
  }
, {
    'short':'filter'
  , 'value':true
  , 'description':'Create a new array with all elements that pass the test implemented by the specified function'
  }
]));

function combine(){
  var map = opts.get('map'),
      reduce = opts.get('reduce'),
      filter = opts.get('filter'),
      args = opts.args();

  args.length == 0 && args.push('./');

  combiner.run(args, {
    'map':map ? evalCallback(map) : undefined
  , 'filter':filter ? evalCallback(filter) : undefined
  , 'reduce':reduce ? evalCallback(reduce) : undefined
  },function(error, result){
    if(error){
      console.log('Error Occured:'+error.message);
      console.log(error.stack);
    } else {
      puts(result);
    }
  });
}

function evalCallback(source){
  return eval('(function(){ return '+source+' })()'); 
}

function version(){
  puts(REV);
  process.exit(0);
}

combine();
