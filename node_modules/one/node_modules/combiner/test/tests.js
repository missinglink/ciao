var combiner = require("../lib/combiner"),
    assert = require("assert");

function test_chain(callback){
  assert.equal(typeof combiner.chain, 'function');
  combiner.chain(['./'],function(error, result){
    if(error) throw error;
    assert.equal(typeof result, 'string'); 
    callback();
  });
}

function test_findFiles(callback){
  combiner.findFiles(['./'], function(error, files){
    if(error){
      throw error;
    }

    assert.equal(files.length, 2);
    callback();
  });
}

function test_findFiles_fileList(callback){
  combiner.findFiles(['../lib/combiner.js','tests.js'], function(error, files){
    if(error){
      throw error;
    }

    assert.equal(files.length, 2);
    assert.equal(files[0], '../lib/combiner.js');
    assert.equal(files[1], 'tests.js');
    callback();
  });
}

function test_filter(callback){
  var files = ['foo','bar','qux','quux','corge'];

  combiner.middleware.filter.push(function(file, callback){
    callback(!/x/.test(file));
  });

  combiner.filter(files, function(error, filtered){
    assert.equal(filtered.length, 3);
    assert.equal(filtered[0], 'foo');
    assert.equal(filtered[1], 'bar');
    assert.equal(filtered[2], 'corge');

    callback();
  });
}

function test_flatten(callback){
  combiner.flatten([[1,2,[3],[4,[5]],[6,[7]]]], function(error, result){
    assert.equal(result.reduce(function(x,y){ return x+y }), 28);
    callback();
  });
}

function test_includeDirs(callback){
  combiner.includeDirectories(['../lib'], function(error, files){
    if(error){
      throw error;
    }
    assert.equal(files.length, 1);
    assert.equal(files[0].length, 1);
    assert.equal(files[0][0], '../lib/combiner.js');
    callback();
  });
}

function test_includeDirs_nested(callback){
  combiner.findFiles(['../'], function(error, index){
    if(error){
      throw error;
    }

    combiner.includeDirectories(index, function(error, _files){
      if(error){
        throw error;
      }

      combiner.flatten(_files, function(error, files){
        if(error){
          throw error;
        }

        assert.ok(files.indexOf('../lib/combiner.js')>-1);
        assert.ok(files.indexOf('../test/tests.js')>-1);
        assert.ok(files.indexOf('../bin/combiner.js')>-1);

        callback();
      });
    });
  });
}

function test_map(callback){
  var files = ['foo','bar','qux','quux','corge'];

  combiner.middleware.map.splice(0,1,function(file, callback){
    callback(undefined, file+'.');
  });

  combiner.map(files, function(error, results){
    if(error) throw error;
    assert.equal(results.length, 5);
    assert.equal(results[0], 'foo.');
    assert.equal(results[1], 'bar.');
    assert.equal(results[2], 'qux.');
    assert.equal(results[3], 'quux.');
    assert.equal(results[4], 'corge.');
    callback();
  });
}

function test_read(callback){
  combiner.read('../Makefile', function(error, data){
    if(error){
      throw error;
    }
    assert.ok(/PHONY/.test(data));
    callback();
  });
}

function test_reduce(callback){
  var ctx = ['a','b','c'];
  combiner.reduce(ctx, function(error, result){
    if(error){
      throw error;
    }

    assert.equal(result, 'a\n\nb\n\nc');
    callback();
  });
}

function test_reduce_middleware(callback){
  
  var ctx = ['a','b','c'];

  combiner.middleware.reduce = function(x,y,cb){
    cb(undefined,x+y);
  };

  combiner.reduce(ctx, function(error, result){
    if(error){
      throw error;
    }

    assert.equal(result, 'abc');
    callback();
  });
}

function test_run(callback){
  var middleware = {
    'reduce':function(x,y,callback){
      callback(null,x+','+y);
    },
    'map':function(el,callback){
      callback(null,el.substring(0,1));  
    },
    'filter':function(el,callback){
      callback(/^\.\.\/test/.test(el));
    }
  };
  combiner.run(['../'],middleware,function(error, result){
    if(error) throw error;
    assert.equal(result,'v,v');
    callback();
  });
}

function reset(){
  combiner.middleware.filter.splice(0);
  combiner.middleware.map.splice(0,99,combiner.read);
}

var tests = {
  'test_flatten':test_flatten,
  'test_chain':test_chain,
  'test_filter':test_filter,
  'test_map':test_map,
  'test_findFiles':test_findFiles,
  'test_findFiles_fileList':test_findFiles_fileList,
  'test_includeDirs_nested':test_includeDirs_nested,
  'test_includeDirs':test_includeDirs,
  'test_read':test_read,
  'test_reduce':test_reduce,
  'test_reduce_middleware':test_reduce_middleware,
  'test_run':test_run,
  'reset':reset
};

typeof module != 'undefined' && ( module.exports = tests );
