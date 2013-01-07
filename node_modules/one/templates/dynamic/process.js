/**
 * This is module's purpose is to partly emulate NodeJS' process object on web browsers. It's not an alternative
 * and/or implementation of the "process" object.
 */

function Buffer(size){
  if (!(this instanceof Buffer)) return new Buffer(size);
  this.content = '';
};

Buffer.prototype.isBuffer = function isBuffer(){
  return true;
};

Buffer.prototype.write = function write(string){
  this.content += string;
};

global.Buffer = exports.Buffer = Buffer;

function Stream(writable, readable){
  if (!(this instanceof Stream)) return new Stream(writable, readable);

  Buffer.call(this);

  this.emulation = true;
  this.readable = readable;
  this.writable = writable;
  this.type = 'file';
};

Stream.prototype = Buffer(0,0);

exports.Stream = Stream;

function notImplemented(){
  throw new Error('Not Implemented.');
}

exports.binding = (function(){

  var table = {
    'buffer':{ 'Buffer':Buffer, 'SlowBuffer':Buffer }
  };

  return function binding(bname){
    if(!table.hasOwnProperty(bname)){
      throw new Error('No such module.');
    }

    return table[bname];
  };

})();

exports.argv = ['onejs'];

{{^debug}}
exports.env = {};
{{/debug}}

{{#debug}}
exports.env = {{{ env }}};
{{/debug}}

exports.nextTick = function nextTick(fn){
  return setTimeout(fn, 0);
};

exports.stderr = Stream(true, false);
exports.stdin = Stream(false, true);
exports.stdout = Stream(true, false);

exports.version = '{{ version }}';

exports.versions = {{{ versions }}};

/**
 * void definitions
 */

exports.pid =
exports.uptime = 0;

exports.arch =
exports.execPath =
exports.installPrefix =
exports.platform =
exports.title = '';

exports.chdir =
exports.cwd =
exports.exit =
exports.getgid =
exports.setgid =
exports.getuid =
exports.setuid =
exports.memoryUsage =
exports.on =
exports.umask = notImplemented;
