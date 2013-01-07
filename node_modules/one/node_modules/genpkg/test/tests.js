var genpkg = require('../lib/genpkg'),
    index = require('../lib/index'),
    logging = require('../lib/logging'),
    assert = require('assert'),
    kick = require('highkick'),
    fs = require('fs');

function test_manifest(callback){
  var content = 'The quick brown fox jumps over the lazy dog',
      uri = 'http://quux.qux/foo.js';

  var manifest = genpkg.manifest({
    'uri':uri,
    'content':content
  });

  assert.equal(manifest.name, 'foo');
  assert.equal(manifest.uri, uri);

  callback();
}

function test_fetch_http(callback){
  genpkg.fetch('http://kodfabrik.com/helloworld.txt', function(error, body){
    if(error){
      return callback(error);
    }

    assert.equal(body, 'hello world\n');
    callback();
  });
}

function test_fetch_local(callback){
  var filename = 'tmp/helloworld.txt',
      content = 'hello world';

  fs.writeFile(filename, content, function(error) {
    if(error) {
      logging.error('Failed to write tmp/helloworld.txt');
      return callback(error);
    }
    
    genpkg.fetch(filename, function(error, body){
      if(error){
        return callback(error);
      }

      assert.equal(body, content);
      callback();
    });

  });
}

function test_pkg(callback){
  genpkg.pkg({ uri:'http://kodfabrik.com/helloworld.js'}, function(error, result){
    assert.equal(result.content, 'console.log(\'hello world\');\n');
    assert.equal(result.manifest.name, 'helloworld');
    assert.equal(result.manifest.main, 'helloworld');
    callback();
  });
}

function test_save(callback){
  var i = 0;
  genpkg.save({ 'target':'tmp/foo', 'uri':'http://foo', 'manifest':{ 'name':'foo', 'main':'./quux' }, 'content':'3.14' }, function(saveError){
    if(saveError) return callback(saveError);

    assert.equal(++i, 1);

    index.valueOf('foo', function(indexReadError, value){

      if(indexReadError) return callback(indexReadError);

      assert.equal(value.sha1, index.encrypt('3.14'));
      assert.equal(value.uri, 'http://foo');

      fs.readFile('tmp/foo/package.json', function(manifestReadError, manifestContent){

        if(manifestReadError) return callback(manifestReadError);

        fs.readFile('tmp/foo/quux.js', function(moduleReadError, moduleContent){

          if(moduleReadError) return callback(moduleReadError);

          var manifest = JSON.parse(manifestContent);

          assert.equal(manifest.name, 'foo');
          assert.equal(moduleContent, '3.14');
          callback();
        });
        
      });

    });
  });
}


function test_index(callback){
  kick({ module:require('./index'), ordered:true, name:'index' }, function(error, result){
    !error && result.fail && ( error = new Error('Index tests failed.') );
    
    fs.unlink('.genpkg', function(unlinkError){
      callback(error || unlinkError);
    });
  });
}

function test_update(callback){
  var doc1 = 'The quick brown fox jumps over the lazy dog',
      doc2 = 'The quick brown rabbit jumps over the lazy dog';

  fs.writeFileSync('tmp/quickfox.txt',doc1);

  genpkg.save({ 'target':'tmp/corge', 'uri':'tmp/quickfox.txt', 'manifest':{ 'name':'corge', 'main':'./lib/eggs.js' }, 'content':doc1 }, function(saveError){
    if(saveError) return callback(saveError);

    genpkg.update('corge', function(updateError, updated){
      if(updateError) return callback(updateError);
      assert.ok(!updated);

      fs.writeFileSync('tmp/quickfox.txt',doc2);

      genpkg.update('corge', function(updateError, updated){
        if(updateError) return callback(updateError);
        assert.ok(updated);        

        callback();
      });
    });

  });
}


module.exports = {
  'test_manifest':test_manifest,
  'test_fetch_http':test_fetch_http,
  'test_fetch_local':test_fetch_local,
  'test_pkg':test_pkg,
  'test_save':test_save,
  'test_index':test_index,
  'test_update':test_update
}
