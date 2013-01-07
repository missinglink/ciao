# spooks.js

A small and simple library
for creating unit test spies and mock objects
in JavaScript.

[![Build status][ci-image]][ci-status]

## Installation

### Node.js

```
npm install spooks
```

### Browser

```
git clone git@github.com:philbooth/spooks.js.git
```

Or use one of the growing number of package managers, such as
[Jam][jam],
[Bower][bower]
(the package name for both is 'spooks')
or [Component][component] ('philbooth/spooks.js').

## Usage

### Loading the library

#### Node.js

```
var spooks = require('spooks');
```

#### Browser

```
<script type="text/javascript" src="spooks.js/src/spooks.min.js"></script>
```

### Calling the exported functions

Four functions are exported:
`spooks.fn`, `spooks.obj`, `spooks.ctor` and `spooks.mode`.

#### spooks.fn (options)

Returns a spy function,
based on the properties of the `options` argument.

`options.name` must be a string identifying the function,
to be used when fetching the count,
arguments
or contexts
of calls to the returned spy function.
You probably want this to match
the actual name of the function,
although it doesn't have to
(for example,
you may need to avoid name clashes
with other properties on the log object).

`options.log` must be a non-null object
that will be used to store the count of calls made to the spy,
any arguments passed to it
and the `this` context for each call,
on the `counts[name]`,
`args[name]`
and `these[name]`
properties respectively.

`options.chain` is an optional boolean
that can be used to indicate that
the returned spy function should support chaining
(i.e. return it's own `this` when invoked).

`options.result` is an optional result
that will be returned by the returned spy function
(ignored if `chain` is `true`).

e.g. to mock the `setTimeout` function:

```
// Create the spy function.
var log = {}, originalSetTimeout = setTimeout;
setTimeout = spooks.fn({
    name: 'setTimeout',
    log: log
});

// Perform some test setup.
...

// Assert that the spy was called as expected.
assert.strictEqual(log.counts.setTimeout, 1);
assert.lengthOf(log.args.setTimeout[0], 2);
assert.isFunction(log.args.setTimeout[0][0]);
assert.strictEqual(log.args.setTimeout[0][1], 1000);

// Reinstate the original function.
setTimeout = originalSetTimeout;
```

#### spooks.obj (options)

Returns a mock object,
containing spy methods
based on the properties of the `options` argument.

`options.archetype` must be a non-null object
that will be used as a template
from which to define the mock object.

`options.mode` is an optional mode constant,
as returned by the function `spooks.mode`,
that indicates precisely which properties from the archetype
should be mocked.
See the documentation for `spooks.mode`,
further down in this document,
for more information about mocking modes.

`options.log` must be a non-null object
that will be used to store counts of spy method calls,
any arguments passed to those methods
and the `this` context for each call,
on the `counts`, `args` and `these` properties respectively.

`options.spook` is an optional object
that can be used as the base mock object
to augment with spy methods.
If it is not specified,
a fresh mock will be returned instead.

`options.chains` is an optional object
containing boolean flags that indicate whether
spy methods should support chaining.
The flags are keyed by method name.

`options.results` is an optional object
containing values that will be returned
from spy methods.
The values are keyed by method name.

e.g. to mock jQuery:

```
// Create the mock object.
var log = {},
jqElement = spooks.obj({
    archetype: jQuery('body'),
    log: log
});
$ = spooks.fn({
    name: 'jQuery',
    log: log,
    result: jqElement
});
spooks.obj({
    archetype: jQuery,
    log: log,
    spook: $
});

// Perform some test setup.
...

// Assert that the spies were called as expected.
assert.strictEqual(log.counts.jQuery, 1);
assert.lengthOf(log.args.jQuery[0], 1);
assert.strictEqual(log.args.jQuery[0][0], '#input-user-id');
assert.strictEqual(log.counts.ajax, 1);
assert.lengthOf(log.args.ajax[0], 2);
assert.strictEqual(log.args.ajax[0][0], '/users/1.json');
assert.isObject(log.args.ajax[0][1]);

// Reinstate the original object.
$ = jQuery;
```

#### spooks.ctor (options)

Returns a spy constructor,
which itself returns mock instances
that contain spy methods
based on the properties of the `options` argument.

`options.name` must be a string identifying the constructor,
to be used when fetching the count,
arguments
or contexts
of calls to the returned spy function.
You probably want this to match
the actual name of the function,
although it doesn't have to
(for example,
you may need to avoid name clashes
with other properties on the log object).

`options.log` must be a non-null object
that will be used to store the count of calls made to the constructor,
any arguments passed to it
and the `this` context for each call,
on the `counts[name]`,
`args[name]`
and `these[name]`
properties respectively.

`options.archetype` must be an object
containing properties that define
how to construct the mock instances
that will be returned by the constructor.
It must have either the property `instance`,
an object that will be used as the template for mock instances,
or the property `ctor`,
a function that returns the template
(usually this would be the original constructor that is being mocked).
If `ctor` is specified
the array property `args` may also be set
to specify any arguments which must be passed to that function.

`options.mode` is an optional mode constant,
as returned by the function `spooks.mode`,
that indicates precisely which properties from the archetype
should be mocked.
See the documentation for `spooks.mode`,
further down in this document,
for more information about mocking modes.

`options.chains` is an optional object
containing boolean flags that indicate whether
spy methods of the mock instances should support chaining.
The flags are keyed by method name.

`options.results` is an optional object
containing values that will be returned
from spy methods of the mock instances.
The values are keyed by method name.

e.g. to mock `Task` instances from your model layer:

```
// Create the spy constructor.
var log = {}, originalTask = Task;
Task = spooks.ctor({
	name: 'Task',
	log: log,
	archetype: {
		ctor: Task
	},
	results:
		isDone: false
	}
});

// Perform some test setup.
...

// Assert that the spies were called as expected.
assert.strictEqual(log.counts.Task, 1);
assert.lengthOf(log.args.Task[0], 0);
assert.strictEqual(log.counts.isDone, 1);

// Reinstate the original object.
Task = originalTask;
```

#### spooks.mode (modes)

Returns a mode constant
that can be used to modify the mocking behaviour of the other functions.

`modes` must be a string
containing a comma-separated list of desired modes,
combined in any order.
Valid modes are 'wide', 'deep' and 'heavy'.
Whitespace is ignored.

The deault mode,
assumed by every function in the absence of these constants,
is to mock only the archetype's own function properties.
That is to say,
any properties of the archetype
which are not functions
or are inherited from the prototype chain
will not be mocked.

`wide` indicates that
mock objects will be assigned copies
of the archetype's value properties
(strings, numbers, booleans)
in addition to its functions.

`deep` indicates that
mock objects will be given a deep-cloned copy
of any object properties on the archetype.

`heavy` indicates that
mock objects will be given copies
of properties from the archetype's prototype chain.

All combination of these modes are valid.
Any modes not recognised will cause an exception to be thrown.

## Development

### Dependencies

The build environment relies on
[Node.js][node],
[NPM],
[Jake],
[JSHint],
[Mocha],
[Chai] and
[UglifyJS].
Assuming that you already have Node.js and NPM set up,
you just need to run `npm install`
to install all of the dependencies
as listed in `package.json`.

### Unit tests

The unit tests are in `test/spooks.js`.
You can run them with the command `npm test`
or `jake jstest`.

[ci-image]: https://secure.travis-ci.org/philbooth/spooks.js.png?branch=master
[ci-status]: http://travis-ci.org/#!/philbooth/spooks.js
[jam]: http://jamjs.org/
[ender]: https://github.com/ender-js/Ender
[bower]: https://github.com/twitter/bower
[component]: https://github.com/component/component
[node]: http://nodejs.org/
[npm]: https://npmjs.org/
[jake]: https://github.com/mde/jake
[jshint]: https://github.com/jshint/node-jshint
[mocha]: http://visionmedia.github.com/mocha
[chai]: http://chaijs.com/
[uglifyjs]: https://github.com/mishoo/UglifyJS

