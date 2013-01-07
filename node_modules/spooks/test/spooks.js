'use strict';

var assert = require('chai').assert,
    module = '../src/spooks';

suite('no setup:', function () {
    test('require does not throw', function () {
        assert.doesNotThrow(function () {
            require(module);
        });
    });

    test('require returns an object', function () {
        assert.isObject(require(module));
    });
});

suite('require:', function () {
    var spooks, archetype;

    setup(function () {
        spooks = require(module);
        archetype = {};
    });

    teardown(function () {
        spooks = archetype = undefined;
    });

    test('fn function is defined', function () {
        assert.isFunction(spooks.fn);
    });

    test('calling fn with an empty object throws', function () {
        assert.throws(function () {
            spooks.fn({});
        });
    });

    test('calling fn with valid arguments does not throw', function () {
        assert.doesNotThrow(function () {
            spooks.fn({
                name: 'foo',
                log: {}
            });
        });
    });

    test('calling fn with object name argument throws', function () {
        assert.throws(function () {
            spooks.fn({
                name: {},
                log: {}
            });
        });
    });

    test('calling fn with number name argument throws', function () {
        assert.throws(function () {
            spooks.fn({
                name: 42,
                log: {}
            });
        });
    });

    test('calling fn with null log argument throws', function () {
        assert.throws(function () {
            spooks.fn({
                name: 'foo',
                log: null
            });
        });
    });

    test('calling fn with valid arguments returns function', function () {
        assert.isFunction(spooks.fn({
            name: 'bar',
            log: {}
        }));
    });

    test('obj function is defined', function () {
        assert.isFunction(spooks.obj);
    });

    test('calling obj with an empty object throws', function () {
        assert.throws(function () {
            spooks.obj(archetype, {});
        });
    });

    test('calling obj with valid arguments does not throw', function () {
        assert.doesNotThrow(function () {
            spooks.obj({
                archetype: {},
                log: {}
            });
        });
    });

    test('calling obj with null archetype argument throws', function () {
        assert.throws(function () {
            spooks.obj({
                archetype: null,
                log: {}
            });
        });
    });

    test('calling obj with null log argument throws', function () {
        assert.throws(function () {
            spooks.obj({
                archetype: {},
                log: null
            });
        });
    });

    test('calling obj with valid arguments returns object', function () {
        assert.isObject(spooks.obj({
            archetype: {},
            log: {}
        }));
    });

    test('calling obj with function spook argument returns function', function () {
        assert.isFunction(spooks.obj({
            spook: function () {},
            archetype: {},
            log: {}
        }));
    });

    test('ctor function is defined', function () {
        assert.isFunction(spooks.ctor);
    });

    test('calling ctor with an empty object throws', function () {
        assert.throws(function () {
            spooks.ctor({});
        });
    });

    test('calling ctor with valid instance arguments does not throw', function () {
        assert.doesNotThrow(function () {
            spooks.ctor({
                name: 'foo',
                log: {},
                archetype: {
                    instance: {}
                }
            });
        });
    });

    test('calling ctor with valid ctor arguments does not throw', function () {
        assert.doesNotThrow(function () {
            spooks.ctor({
                name: 'foo',
                log: {},
                archetype: {
                    ctor: function () {}
                }
            });
        });
    });

    test('calling ctor with invalid instance argument throws', function () {
        assert.throws(function () {
            spooks.ctor({
                name: 'foo',
                log: {},
                archetype: {
                    instance: 'bar'
                }
            });
        });
    });

    test('calling ctor with invalid ctor argument throws', function () {
        assert.throws(function () {
            spooks.ctor({
                name: 'foo',
                log: {},
                archetype: {
                    ctor: {}
                }
            });
        });
    });

    test('calling ctor with invalid conditional ctor argument throws', function () {
        assert.throws(function () {
            spooks.ctor({
                name: 'foo',
                log: {},
                archetype: {
                    ctor: function () {
                        if (arguments.length !== 1 || arguments[0] !== 'bar') {
                            throw new Error();
                        }
                    },
                    args: [ 'baz' ]
                }
            });
        });
    });

    test('calling ctor with valid conditional ctor argument does not throw', function () {
        assert.doesNotThrow(function () {
            spooks.ctor({
                name: 'foo',
                log: {},
                archetype: {
                    ctor: function () {
                        if (arguments.length !== 1 || arguments[0] !== 'bar') {
                            throw new Error();
                        }
                    },
                    args: [ 'bar' ]
                }
            });
        });
    });

    test('calling ctor with valid instance arguments returns function', function () {
        assert.isFunction(spooks.ctor({
            name: 'foo',
            log: {},
            archetype: {
                instance: {}
            }
        }));
    });

    test('calling ctor with valid ctor arguments returns function', function () {
        assert.isFunction(spooks.ctor({
            name: 'foo',
            log: {},
            archetype: {
                ctor: function () { return {}; }
            }
        }));
    });

    test('calling ctor(instance) result returns object', function () {
        assert.isObject(spooks.ctor({
            name: 'foo',
            log: {},
            archetype: {
                instance: {}
            }
        })());
    });

    test('calling ctor(ctor) result returns object', function () {
        assert.isObject(spooks.ctor({
            name: 'foo',
            log: {},
            archetype: {
                ctor: function () { return {}; }
            }
        })());
    });

    test('calling conditional ctor(ctor) result returns object', function () {
        assert.isObject(spooks.ctor({
            name: 'foo',
            log: {},
            archetype: {
                ctor: function () {
                    if (arguments.length === 1 && arguments[0] === 'foo') {
                        return {};
                    }
                },
                args: [ 'foo' ]
            }
        })());
    });

    test('mode function is defined', function () {
        assert.isFunction(spooks.mode);
    });

    test('mode with no arguments throws', function () {
        assert.throws(spooks.mode);
    });

    test('mode with invalid string throws', function () {
        assert.throws(function () {
            spooks.mode('narrow');
        });
    });

    test('mode with valid string does not throw', function () {
        assert.doesNotThrow(function () {
            spooks.mode('wide');
        });
    });

    test('mode with wide returns 1', function () {
        assert.strictEqual(spooks.mode('wide'), 1);
    });

    test('mode with deep returns 2', function () {
        assert.strictEqual(spooks.mode('deep'), 2);
    });

    test('mode with heavy returns 4', function () {
        assert.strictEqual(spooks.mode('heavy'), 4);
    });

    test('mode with wide,deep returns 3', function () {
        assert.strictEqual(spooks.mode('wide,deep'), 3);
    });

    test('mode ignores whitespace', function () {
        assert.strictEqual(spooks.mode(' wide , \t\tdeep\t'), 3);
    });

    suite('call fn with name and log:', function () {
        var log, fn;

        setup(function () {
            log = {};
            fn = spooks.fn({
                name: 'foo',
                log: log
            });
        });

        teardown(function () {
            log = fn = undefined;
        });

        test('log has counts object', function () {
            assert.isObject(log.counts);
        });

        test('log.counts.foo is zero', function () {
            assert.strictEqual(log.counts.foo, 0);
        });

        test('log has args object', function () {
            assert.isObject(log.args);
        });

        test('log.args has foo array', function () {
            assert.isArray(log.args.foo);
        });

        test('log.args.foo has length zero', function () {
            assert.lengthOf(log.args.foo, 0);
        });

        test('log has these object', function () {
            assert.isObject(log.these);
        });

        test('log.these has foo array', function () {
            assert.isArray(log.these.foo);
        });

        test('log.these.foo has length zero', function () {
            assert.lengthOf(log.these.foo, 0);
        });

        test('calling spooked function does not throw', function () {
            assert.doesNotThrow(function () {
                fn();
            });
        });

        test('calling spooked function returns undefined', function () {
            assert.isUndefined(fn());
        });

        suite('call spooked function with one argument:', function () {
            setup(function () {
                fn('foo');
            });

            test('log.counts.foo is one', function () {
                assert.strictEqual(log.counts.foo, 1);
            });

            test('log.args.foo has length one', function () {
                assert.lengthOf(log.args.foo, 1);
            });

            test('log.args.foo[0] has length one', function () {
                assert.lengthOf(log.args.foo[0], 1);
            });

            test('log.args.foo[0][0] is foo', function () {
                assert.strictEqual(log.args.foo[0][0], 'foo');
            });

            test('log.these.foo has length one', function () {
                assert.lengthOf(log.these.foo, 1);
            });

            test('log.these.foo[0] is undefined', function () {
                assert.isUndefined(log.these.foo[0]);
            });

            suite('call spooked function with a different argument:', function () {
                setup(function () {
                    fn('bar');
                });

                test('log.counts.foo is two', function () {
                    assert.strictEqual(log.counts.foo, 2);
                });

                test('log.args.foo has length two', function () {
                    assert.lengthOf(log.args.foo, 2);
                });

                test('log.args.foo[0] has length one', function () {
                    assert.lengthOf(log.args.foo[0], 1);
                });

                test('log.args.foo[0][0] is foo', function () {
                    assert.strictEqual(log.args.foo[0][0], 'foo');
                });

                test('log.args.foo[1] has length one', function () {
                    assert.lengthOf(log.args.foo[1], 1);
                });

                test('log.args.foo[1][0] is bar', function () {
                    assert.strictEqual(log.args.foo[1][0], 'bar');
                });

                test('log.these.foo has length two', function () {
                    assert.lengthOf(log.these.foo, 2);
                });

                test('log.these.foo[0] is undefined', function () {
                    assert.isUndefined(log.these.foo[0]);
                });

                test('log.these.foo[1] is undefined', function () {
                    assert.isUndefined(log.these.foo[1]);
                });

                suite('call spooked function with multiple arguments:', function () {
                    setup(function () {
                        fn('foo', 'bar', 'baz');
                    });

                    test('log.counts.foo is three', function () {
                        assert.strictEqual(log.counts.foo, 3);
                    });

                    test('log.args.foo has length three', function () {
                        assert.lengthOf(log.args.foo, 3);
                    });

                    test('log.args.foo[0] has length one', function () {
                        assert.lengthOf(log.args.foo[0], 1);
                    });

                    test('log.args.foo[0][0] is foo', function () {
                        assert.strictEqual(log.args.foo[0][0], 'foo');
                    });

                    test('log.args.foo[1] has length one', function () {
                        assert.lengthOf(log.args.foo[1], 1);
                    });

                    test('log.args.foo[1][0] is bar', function () {
                        assert.strictEqual(log.args.foo[1][0], 'bar');
                    });

                    test('log.args.foo[2] has length three', function () {
                        assert.lengthOf(log.args.foo[2], 3);
                    });

                    test('log.args.foo[2][0] is foo', function () {
                        assert.strictEqual(log.args.foo[2][0], 'foo');
                    });

                    test('log.args.foo[2][1] is bar', function () {
                        assert.strictEqual(log.args.foo[2][1], 'bar');
                    });

                    test('log.args.foo[2][2] is baz', function () {
                        assert.strictEqual(log.args.foo[2][2], 'baz');
                    });
                });
            });
        });
    });

    suite('call fn with different name:', function () {
        var log, fn;

        setup(function () {
            log = {};
            fn = spooks.fn({
                name: 'bar',
                log: log
            });
        });

        teardown(function () {
            log = fn = undefined;
        });

        test('log.counts.foo is undefined', function () {
            assert.isUndefined(log.counts.foo);
        });

        test('log.counts.bar is zero', function () {
            assert.strictEqual(log.counts.bar, 0);
        });

        test('log.args.foo is undefined', function () {
            assert.isUndefined(log.args.foo);
        });

        test('log.args.bar has length zero', function () {
            assert.lengthOf(log.args.bar, 0);
        });

        test('log.these.foo is undefined', function () {
            assert.isUndefined(log.these.foo);
        });

        test('log.these.bar has length zero', function () {
            assert.lengthOf(log.these.bar, 0);
        });

        suite('call spooked function with one argument:', function () {
            setup(function () {
                fn('baz');
            });

            test('log.counts.bar is one', function () {
                assert.strictEqual(log.counts.bar, 1);
            });

            test('log.args.bar has length one', function () {
                assert.lengthOf(log.args.bar, 1);
            });

            test('log.args.bar[0] has length one', function () {
                assert.lengthOf(log.args.bar[0], 1);
            });

            test('log.args.bar[0][0] is baz', function () {
                assert.strictEqual(log.args.bar[0][0], 'baz');
            });
        });
    });

    suite('call fn with result:', function () {
        var log, fn;

        setup(function () {
            log = {};
            fn = spooks.fn({
                name: 'baz',
                log: log,
                result: 'foo'
            });
        });

        teardown(function () {
            log = fn = undefined;
        });

        test('log.counts.foo is undefined', function () {
            assert.isUndefined(log.counts.foo);
        });

        test('log.counts.bar is undefined', function () {
            assert.isUndefined(log.counts.bar);
        });

        test('log.counts.baz is zero', function () {
            assert.strictEqual(log.counts.baz, 0);
        });

        test('log.args.foo is undefined', function () {
            assert.isUndefined(log.args.foo);
        });

        test('log.args.bar is undefined', function () {
            assert.isUndefined(log.args.bar);
        });

        test('log.args.baz has length zero', function () {
            assert.lengthOf(log.args.baz, 0);
        });

        test('calling spooked function returns foo', function () {
            assert.strictEqual(fn(), 'foo');
        });
    });

    suite('call fn with different result:', function () {
        var fn;

        setup(function () {
            fn = spooks.fn({
                name: 'foo',
                log: {},
                result: 'bar'
            });
        });

        teardown(function () {
            fn = undefined;
        });

        test('calling spooked function returns bar', function () {
            assert.strictEqual(fn(), 'bar');
        });
    });

    suite('call fn with chain true:', function () {
        var object;

        setup(function () {
            object = {
                fn: spooks.fn({
                    name: 'foo',
                    log: {},
                    chain: true
                })
            };
        });

        teardown(function () {
            object = undefined;
        });

        test('calling spooked function returns spooked function', function () {
            assert.strictEqual(object.fn(), object);
        });
    });

    suite('call fn with chain false:', function () {
        var fn;

        setup(function () {
            fn = spooks.fn({
                name: 'foo',
                log: {},
                chain: false
            });
        });

        teardown(function () {
            fn = undefined;
        });

        test('calling spooked function returns undefined', function () {
            assert.isUndefined(fn());
        });
    });

    suite('call fn with chain true and result:', function () {
        var object;

        setup(function () {
            object = {
                fn: spooks.fn({
                    name: 'foo',
                    log: {},
                    chain: true,
                    result: 'bar'
                })
            };
        });

        teardown(function () {
            object = undefined;
        });

        test('calling spooked function returns context object function', function () {
            assert.strictEqual(object.fn(), object);
        });
    });

    suite('call fn in specific context:', function () {
        var log, object;

        setup(function () {
            log = {};
            object = {
                fn: spooks.fn({
                    name: 'foo',
                    log: log
                })
            };
            object.fn();
        });

        teardown(function () {
            log = object = undefined;
        });

        test('log.these.foo[0] is context object', function () {
            assert.strictEqual(log.these.foo[0], object);
        });
    });

    suite('call obj with archetype, log and results:', function () {
        var log, object;

        setup(function () {
            log = {};
            object = spooks.obj({
                archetype: {
                    foo: function () {},
                    bar: function () {}
                },
                log: log,
                results: {
                    bar: 'bar'
                }
            });
        });

        teardown(function () {
            log = object = undefined;
        });

        test('log has counts object', function () {
            assert.isObject(log.counts);
        });

        test('log.counts.foo is zero', function () {
            assert.strictEqual(log.counts.foo, 0);
        });

        test('log has args object', function () {
            assert.isObject(log.args);
        });

        test('log.args has foo array', function () {
            assert.isArray(log.args.foo);
        });

        test('log.args.foo has length zero', function () {
            assert.lengthOf(log.args.foo, 0);
        });

        test('log has these object', function () {
            assert.isObject(log.these);
        });

        test('log.these has foo array', function () {
            assert.isArray(log.these.foo);
        });

        test('log.these.foo has length zero', function () {
            assert.lengthOf(log.these.foo, 0);
        });

        test('log.counts.bar is zero', function () {
            assert.strictEqual(log.counts.bar, 0);
        });

        test('log.args has bar array', function () {
            assert.isArray(log.args.bar);
        });

        test('log.args.bar has length zero', function () {
            assert.lengthOf(log.args.bar, 0);
        });

        test('log.these has bar array', function () {
            assert.isArray(log.these.bar);
        });

        test('log.these.bar has length zero', function () {
            assert.lengthOf(log.these.bar, 0);
        });

        test('object has method foo', function () {
            assert.isFunction(object.foo);
        });

        test('calling spooked method foo does not throw', function () {
            assert.doesNotThrow(function () {
                object.foo();
            });
        });

        test('calling spooked method foo returns undefined', function () {
            assert.isUndefined(object.foo());
        });

        test('object has method bar', function () {
            assert.isFunction(object.bar);
        });

        test('calling spooked method bar does not throw', function () {
            assert.doesNotThrow(function () {
                object.bar();
            });
        });

        test('calling spooked method bar returns bar', function () {
            assert.strictEqual(object.bar(), 'bar');
        });

        suite('call spooked method foo:', function () {
            setup(function () {
                object.foo();
            });

            test('log.counts.foo is one', function () {
                assert.strictEqual(log.counts.foo, 1);
            });

            test('log.args.foo has length one', function () {
                assert.lengthOf(log.args.foo, 1);
            });

            test('log.args.foo[0] has length zero', function () {
                assert.lengthOf(log.args.foo[0], 0);
            });

            test('log.counts.bar is zero', function () {
                assert.strictEqual(log.counts.bar, 0);
            });

            test('log.args.bar has length zero', function () {
                assert.lengthOf(log.args.bar, 0);
            });

            suite('call spooked method foo with arguments:', function () {
                setup(function () {
                    object.foo('bar', 'baz');
                });

                test('log.counts.foo is two', function () {
                    assert.strictEqual(log.counts.foo, 2);
                });

                test('log.args.foo has length two', function () {
                    assert.lengthOf(log.args.foo, 2);
                });

                test('log.args.foo[1] has length two', function () {
                    assert.lengthOf(log.args.foo[1], 2);
                });

                test('log.args.foo[1][0] is bar', function () {
                    assert.strictEqual(log.args.foo[1][0], 'bar');
                });

                test('log.args.foo[1][1] is baz', function () {
                    assert.strictEqual(log.args.foo[1][1], 'baz');
                });
            });
        });

        suite('call spooked method bar:', function () {
            setup(function () {
                object.bar();
            });

            test('log.counts.foo is zero', function () {
                assert.strictEqual(log.counts.foo, 0);
            });

            test('log.args.foo has length zero', function () {
                assert.lengthOf(log.args.foo, 0);
            });

            test('log.counts.bar is one', function () {
                assert.strictEqual(log.counts.bar, 1);
            });

            test('log.args.bar has length one', function () {
                assert.lengthOf(log.args.bar, 1);
            });

            test('log.args.bar[0] has length zero', function () {
                assert.lengthOf(log.args.bar[0], 0);
            });
        });
    });

    suite('call obj with spook:', function () {
        var spook;

        setup(function () {
            spook = {};
            spooks.obj({
                archetype: {
                    foo: function () {}
                },
                log: {},
                spook: spook
            });
        });

        teardown(function () {
            spook = undefined;
        });

        test('spook has method foo', function () {
            assert.isFunction(spook.foo);
        });
    });

    suite('call obj with chains and returns:', function () {
        var log, object;

        setup(function () {
            log = {};
            object = spooks.obj({
                archetype: {
                    foo: function () {},
                    bar: function () {}
                },
                log: {},
                chains: {
                    bar: true
                },
                results: {
                    foo: 'foo',
                    bar: 'bar'
                }
            });
        });

        teardown(function () {
            log = object = undefined;
        });

        test('object.foo returns foo', function () {
            assert.strictEqual(object.foo(), 'foo');
        });

        test('object.bar returns object', function () {
            assert.strictEqual(object.bar(), object);
        });
    });

    suite('call ctor with actual constructor [sanity check]:', function () {
        var log, Mock, instance;

        setup(function () {
            log = {};
            Mock = spooks.ctor({
                name: 'Ctor',
                log: log,
                archetype: {
                    ctor: Ctor
                },
                chains: {
                    foo: true
                },
                results: {
                    bar: 'baz'
                }
            });
            instance = new Mock();

            function Ctor () {
                this.foo = function () {};
                this.bar = function () {};
                this.baz = 'baz';
                this.qux = {
                    foo: function () {},
                    bar: 'bar'
                };
                return this;
            }
        });

        teardown(function () {
            log = Mock = instance = undefined;
        });

        test('instance has method foo', function () {
            assert.isFunction(instance.foo);
        });

        test('instance has method bar', function () {
            assert.isFunction(instance.bar);
        });

        test('instance does not have property baz', function () {
            assert.isUndefined(instance.baz);
        });

        test('instance does not have property qux', function () {
            assert.isUndefined(instance.qux);
        });

        test('instance has two properties', function () {
            var count = 0, property;

            for (property in instance) {
                if (instance.hasOwnProperty(property)) {
                    count += 1;
                }
            }

            assert.strictEqual(count, 2);
        });

        test('instance.foo returns instance', function () {
            assert.strictEqual(instance.foo(), instance);
        });

        test('instance.bar returns baz', function () {
            assert.strictEqual(instance.bar(), 'baz');
        });

        test('log.counts.foo is zero', function () {
            assert.strictEqual(log.counts.foo, 0);
        });

        test('log.counts.bar is zero', function () {
            assert.strictEqual(log.counts.bar, 0);
        });
    });

    suite('call ctor with wide mode set:', function () {
        var Mock, instance;

        setup(function () {
            Mock = spooks.ctor({
                name: 'Ctor',
                log: {},
                archetype: {
                    ctor: Ctor
                },
                mode: spooks.mode('wide')
            });
            instance = new Mock();

            function Ctor () {
                this.foo = function () {};
                this.bar = function () {};
                this.baz = 'baz';
                this.qux = {
                    foo: function () {},
                    bar: 'bar'
                };
                return this;
            }
        });

        teardown(function () {
            Mock = instance = undefined;
        });

        test('instance has property baz', function () {
            assert.strictEqual(instance.baz, 'baz');
        });

        test('instance does not have property qux', function () {
            assert.isUndefined(instance.qux);
        });
    });

    suite('call ctor with deep mode set:', function () {
        var Mock, instance;

        setup(function () {
            Mock = spooks.ctor({
                name: 'Ctor',
                log: {},
                archetype: {
                    ctor: Ctor
                },
                mode: spooks.mode('deep')
            });
            instance = new Mock();

            function Ctor () {
                this.foo = function () {};
                this.bar = function () {};
                this.baz = 'baz';
                this.qux = {
                    foo: function () {},
                    bar: 'bar'
                };
                return this;
            }
        });

        teardown(function () {
            Mock = instance = undefined;
        });

        test('instance does not have property baz', function () {
            assert.isUndefined(instance.baz);
        });

        test('instance has property qux', function () {
            assert.isObject(instance.qux);
        });

        test('qux.foo is function', function () {
            assert.isFunction(instance.qux.foo);
        });

        test('qux.bar is undefined', function () {
            assert.isUndefined(instance.qux.bar);
        });
    });

    suite('call ctor with wide and deep modes set:', function () {
        var Mock, instance;

        setup(function () {
            Mock = spooks.ctor({
                name: 'Ctor',
                log: {},
                archetype: {
                    ctor: Ctor
                },
                mode: spooks.mode('wide,deep')
            });
            instance = new Mock();

            function Ctor () {
                this.foo = function () {};
                this.bar = function () {};
                this.baz = 'baz';
                this.qux = {
                    foo: function () {},
                    bar: 'bar'
                };
                return this;
            }
        });

        teardown(function () {
            Mock = instance = undefined;
        });

        test('instance has property baz', function () {
            assert.strictEqual(instance.baz, 'baz');
        });

        test('instance has property qux', function () {
            assert.isObject(instance.qux);
        });

        test('qux.foo is function', function () {
            assert.isFunction(instance.qux.foo);
        });

        test('qux.bar is correct', function () {
            assert.strictEqual(instance.qux.bar, 'bar');
        });
    });

    suite('call ctor with heavy mode set:', function () {
        var Ctor, instance;

        setup(function () {
            var Base, Derived;

            Base = function () {};
            Base.prototype.baz = function () {};
            Base.prototype.qux = 'qux';

            Derived = function () {};
            Derived.prototype = new Base();
            Derived.prototype.foo = function () {};
            Derived.prototype.bar = function () {};

            Ctor = spooks.ctor({
                name: 'Ctor',
                log: {},
                archetype: {
                    ctor: Derived
                },
                mode: spooks.mode('heavy')
            });

            instance = new Ctor();
        });

        teardown(function () {
            Ctor = instance = undefined;
        });

        test('instance has method baz', function () {
            assert.isFunction(instance.baz);
        });

        test('instance does not have property qux', function () {
            assert.isUndefined(instance.qux);
        });
    });

    suite('call ctor with wide and heavy modes set:', function () {
        var Ctor, instance;

        setup(function () {
            Derived.prototype = new Base();
            Ctor = spooks.ctor({
                name: 'Ctor',
                log: {},
                archetype: {
                    ctor: Derived
                },
                mode: spooks.mode('wide,heavy')
            });
            instance = new Ctor();

            function Derived () {
                this.foo = function () {};
                this.bar = function () {};
                return this;
            }

            function Base () {
                this.baz = function () {};
                this.qux = 'qux';
                return this;
            }
        });

        teardown(function () {
            Ctor = instance = undefined;
        });

        test('instance has method baz', function () {
            assert.isFunction(instance.baz);
        });

        test('instance has property qux', function () {
            assert.strictEqual(instance.qux, 'qux');
        });
    });
});

