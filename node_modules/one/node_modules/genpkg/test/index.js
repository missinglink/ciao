var index = require('../lib/index'),
    fs = require('fs'),
    assert = require('assert');

function init(options, callback){
  // clean .genpkg file
  fs.unlink('.genpkg', function(error){
    callback(error);
  });
}

function test_contents(callback){
  index.save({ 'foo':'bar' }, function(saveError){
    if(saveError) return callback(saveError);
    
    index.contents(function(error, recs){
      if(error) return callback(error);
      
      assert.equal(recs.foo, 'bar');
      callback();
    });
  });
}

function test_encrypt(callback){
  assert.equal(index.encrypt('The quick brown fox jumps over the lazy dog'), '2fd4e1c67a2d28fced849ee1bb76e7391b93eb12');
  callback();
}

function test_save(callback){
  index.save({ 'foo':'bar' }, function(error){
    if(error) return callback(error);

    index.contents(function(error, recs){
      if(error) return callback(error);      
      
      assert.equal(recs.foo, 'bar');
      callback();
    });
  });
}

function test_update(callback){
  index.save({ 'foo':{ 'sha1':index.encrypt('foo') }, 'bar':{ 'sha1':index.encrypt('b4r') } }, function(saveError){
    if(saveError) return callback(saveError);
    
    index.update('foo', { content:'foo' }, function(error, updated){
      if(error) return callback(error);
      assert.ok(!updated);

      index.update('bar', { content: 'bar' }, function(error, updated){
        if(error) return callback(error);
        assert.ok(updated);
        callback();
      });
    });
    
  });
}

function test_sha1Of(callback){
  index.save({ 'foo':{ 'uri':'bar', 'sha1':'q22x' } }, function(error){
    if(error) return callback(error);

    index.sha1Of('foo', function(error, value){
      if(error) return callback(error);      
      
      assert.equal(value, 'q22x');
      callback();
    });
  });
}

function test_uriOf(callback){
  index.save({ 'foo':{ 'uri':'bar', 'sha1':'q22x' } }, function(error){
    if(error) return callback(error);

    index.uriOf('foo', function(error, uri){
      if(error) return callback(error);      
      
      assert.equal(uri, 'bar');
      callback();
    });
  });
}

function test_valueOf(callback){
  index.save({ 'foo':{ 'uri':'bar', 'sha1':'q22x' } }, function(error){
    if(error) return callback(error);

    index.valueOf('foo', function(error, value){
      if(error) return callback(error);      
      
      assert.equal(value.uri, 'bar');
      assert.equal(value.sha1, 'q22x');

      callback();
    });
  });
}

module.exports = {
  'test_save':test_save,
  'test_update':test_update,
  'test_contents':test_contents,
  'test_valueOf':test_valueOf,
  'test_uriOf':test_uriOf,
  'test_sha1of':test_sha1Of,
  'test_encrypt':test_encrypt
}
