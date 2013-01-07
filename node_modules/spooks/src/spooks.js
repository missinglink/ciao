/**
 * This module exports functions for creating unit test spies and mock objects.
 */

/*globals module, window */

(function () {
    'use strict';

    var constants = {
        wide: 0x1,
        deep: 0x2,
        heavy: 0x4
    },

    functions = {
        ctor: createConstructor,
        obj: createObject,
        fn: createFunction,
        mode: getMode
    };

    if (typeof module === 'undefined' || module === null) {
        window.spooks = functions;
    } else {
        module.exports = functions;
    }

    /**
     * Public function `ctor`.
     *
     * Returns a unit test spy constructor, which returns mock instances that are
     * themselves unit test spies.
     *
     * @option name {object}      The name of the constructor being mocked, used
     *                            as a key into the `log` object.
     * @option log {object}       Object used to store call counts, arguments
     *                            and contexts, on properties `counts[name]`,
     *                            `args[name]` and `these[name]` respecitvely.
     * @option archetype {object} Archetype used to construct the mock instances
     *                            that will be returned by the spy constructor.
     *                            It must have either the property `instance`,
     *                            an object that will be used as the template
     *                            for mock instances, or the property `ctor`, a
     *                            function that returns the template (usually
     *                            this will be the constructor that is being
     *                            mocked). If `ctor` is specified, the property
     *                            `args` may also be set to specify the arguments
     *                            to pass to that function.
     * @option [chains] {object}  Optional object containing flags indicating
     *                            whether methods of the mock instances should
     *                            be chainable.  The flags are keyed by method
     *                            name.
     * @option [results] {object} Optional object containing values that will
     *                            be returned from methods of the mock instances.
     *                            The values are keyed by method name.
     * @option [mode] {mode}      Optional mode specifying how the mock instances
     *                            should be created. For more about modes, see the
     *                            public function `mode` at the bottom of this
     *                            module.
     */
    function createConstructor (options) {
        return createFunction({
            name: options.name,
            log: options.log,
            result: createObject({
                archetype: getArchetype(options.archetype),
                log: options.log,
                chains: options.chains,
                results: options.results,
                mode: options.mode
            })
        });
    }

    function getArchetype (options) {
        if (isObject(options.instance)) {
            return options.instance;
        }

        if (isFunction(options.ctor)) {
            if (isArray(options.args)) {
                return instantiateWithArguments(options.ctor, options.args);
            }

            return new options.ctor();
        }

        throw new Error('Invalid archetype');
    }

    function isObject (thing) {
        return typeof thing === 'object' && thing !== null;
    }

    function isFunction (thing) {
        return typeof thing === 'function';
    }

    function isArray (thing) {
        return Object.prototype.toString.call(thing) === '[object Array]';
    }

    function instantiateWithArguments (constructor, args) {
        Derived.prototype = constructor.prototype;
        return new Derived();

        function Derived () {
            return constructor.apply(this, args);
        }
    }

    /**
     * Public function `obj`.
     *
     * Returns a mock object that contains unit test spy methods.
     *
     * @option archetype {object} Template object. The returned mock will have
     *                            methods matching the archetype's methods.
     * @option log {object}       Object used to store spy method call counts,
     *                            arguments and contexts, on the properties
     *                            `counts`, `args` and `these` respectively.
     * @option [spook] {object}   Optional base object to add spy methods to.
     *                            If not specified, a new clean object will
     *                            be created instead.
     * @option [chains] {object}  Optional object containing flags indicating
     *                            whether spy methods shoulds be chainable.
     *                            The flags are keyed by method name.
     * @option [results] {object} Optional object containing values that will
     *                            be returned from spy methods. The values
     *                            are keyed by method name.
     * @option [mode] {mode}      Optional mode specifying how the mock should be
     *                            created. For more about modes, see the public
     *                            function `mode`, at the bottom of this module.
     */
    function createObject (options) {
        var archetype = options.archetype,
            spook = options.spook || {};

        if (isNotObject(archetype) && isNotFunction(archetype)) {
            throw new Error('Invalid archetype');
        }

        if (isNotObject(options.log)) {
            throw new Error('Invalid log');
        }

        // TODO: Should we also handle mocking arrays? (would just require using processArray at this level)

        processProperties(archetype, spook, {
            log: options.log,
            chains: options.chains || {},
            results: options.results || {},
            mode: options.mode || 0
        });

        return spook;
    }

    function processProperties (source, target, options) {
        var property;

        for (property in source) {
            if (shouldProcessProperty(source, property, options.mode)) {
                target[property] = processProperty(source, property, options);
            }
        }

        return target;
    }

    function processProperty (object, name, options) {
        var property = object[name];

        if (isFunction(property)) {
            return processProperties(property, createFunction({
                name: name,
                log: options.log,
                chain: options.chains[name],
                result: options.results[name]
            }), options);
        }

        if (isNotObject(property)) {
            return property;
        }

        if (isArray(property)) {
            return processArray(property, options);
        }

        return processProperties(property, {}, options);
    }

    function processArray (source, options) {
        var target = [], i;

        for (i = 0; i < source.length; i += 1) {
            target.push(processProperty(source, i, options));
        }

        return target;
    }

    function isNotObject (thing) {
        return isObject(thing) === false;
    }

    function isNotFunction (thing) {
        return isFunction(thing) === false;
    }

    function shouldProcessProperty (object, name, mode) {
        if (object.hasOwnProperty(name) === false && shouldProcessPrototypes(mode) === false) {
            return false;
        }

        if (isObject(object[name])) {
            return shouldProcessObjects(mode);
        }

        if (isNotFunction(object[name])) {
            return shouldProcessValues(mode);
        }

        return true;
    }

    function shouldProcessPrototypes (mode) {
        return isModeSet(constants.heavy, mode);
    }

    function isModeSet (mode, currentModes) {
        /*jshint bitwise:false */
        return (mode & currentModes) === mode;
    }

    function shouldProcessObjects (mode) {
        return isModeSet(constants.deep, mode);
    }

    function shouldProcessValues (mode) {
        return isModeSet(constants.wide, mode);
    }

    /**
     * Public function `fn`.
     *
     * Returns a unit test spy function.
     *
     * @option name {object}     The name of the function being mocked, used
     *                           as a key into the `log` object.
     * @option log {object}      Object used to store call counts, arguments
     *                           and contexts, on properties `counts[name]`,
     *                           `args[name]` and `these[name]` respecitvely.
     * @option [chain] {boolean} Optional flag specifying whether the spy
     *                           function supports chaining (i.e. it returns
     *                           its own `this`). Defaults to `false`.
     * @option [result] {var}    Optional result that will be returned from
     *                           the spy function. Defaults to `undefined`.
     */
    function createFunction (options) {
        var name = options.name,
            chain = options.chain,
            log = options.log,
            result = options.result;

        if (typeof name !== 'string') {
            throw new Error('Invalid function name');
        }

        initialiseLogProperties(log, name, {
            counts: 0,
            args: [],
            these: []
        });

        return function () {
            logFunctionCall(name, log, arguments, this);

            if (chain === true) {
                return this;
            }

            return result;
        };
    }

    function initialiseLogProperties (log, name, properties) {
        var property;

        for (property in properties) {
            if (properties.hasOwnProperty(property)) {
                initialiseLogProperty(log, property, name, properties[property]);
            }
        }
    }

    function initialiseLogProperty (log, property, name, value) {
        initialiseProperty(log, property, {});
        initialiseProperty(log[property], name, value);
    }

    function initialiseProperty (object, property, value) {
        if (typeof object[property] === 'undefined') {
            object[property] = value;
        }
    }

    function logFunctionCall (name, log, args, that) {
        /*jshint validthis:true */
        log.counts[name] += 1;
        log.args[name].push(args);
        log.these[name].push(that);
    }

    /**
     * Public function `mode`.
     *
     * Returns a mode constant that can be used to modify the mocking behaviour of
     * other exported functions.
     *
     * @param modes {string} A comma-separated list of desired modes, combined in any
     *                       order. Valid modes are 'wide', 'deep' and 'heavy'. The
     *                       default mode implied when no modes are specified has a
     *                       constant value of zero and is assumed by every function.
     *                       It is both literally and conceptually the absence of the
     *                       other modes. The 'wide' mode indicates that mock objects
     *                       will be assigned copies of all of their archetype's own
     *                       non-object properties, not just the functions. The 'deep'
     *                       mode indicates that mock objects will be given the nested
     *                       object structure of their archetype. The 'heavy' mode
     *                       indicates that mock objects will be assigned properties
     *                       from the archetype's prototype chain, in addition its own
     *                       properties. All combination of these modes are valid. Any
     *                       modes not recognised will cause an exception to be thrown.
     *                       Whitespace is ignored.
     */
    function getMode (modes) {
        /*jshint bitwise:false */
        var result = 0, keys = modes.split(','), i, mode;

        for (i = 0; i < keys.length; i += 1) {
            mode = constants[keys[i].trim()];

            if (typeof mode === 'undefined') {
                throw new Error('Invalid mode');
            }

            result |= mode;
        }

        return result;
    }
}());

