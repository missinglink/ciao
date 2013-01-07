/**
 * This module exports function for creating and consuming
 * vague dates, e.g. 'yesterday', 'today' or 'next week'.
 */

/*globals module, window */

(function () {
    'use strict';

    var times = {
        day: 86400000, // 1000 ms * 60 s * 60 m * 24 h
        week: 604800000, // 1000 ms * 60 s * 60 m * 24 h * 7 d
        month: 2678400000, // 1000 ms * 60 s * 60 m * 24 h * 31 d
        year: 31536000000 // 1000 ms * 60 s * 60 m * 24 h * 365 d
    },

    cardinalities = {
        day: 7,
        week: 52,
        month: 12
    },

    functions = {
        get: getVagueDate,
        set: setVagueDate
    };

    if (typeof module === 'undefined' || module === null) {
        window.vagueDate = functions;
    } else {
        module.exports = functions;
    }

    /**
     * Public function `get`.
     *
     * Returns a vague date string.
     *
     * @option [from] {Date}    The origin time. Defaults to `Date.now()`.
     * @option [to] {Date}      The target time. Defaults to `Date.now()`.
     * @option [units] {string} If `from` or `to` are timestamps instead of date instances,
     *                          this indicates the units that they're measured in. Can be
     *                          either `ms` for milliseconds or `s` for seconds. Defaults to
     *                          `ms`.
     */
    function getVagueDate (options) {
        var units = normaliseUnits(options.units),
            now = Date.now(),
            from = normaliseTime(options.from, units, now),
            to = normaliseTime(options.to, units, now),
            difference = from.timestamp - to.timestamp,
            absoluteDifference = Math.abs(difference);

        return estimate(absoluteDifference, from, to) || getYearlyDifference(absoluteDifference, difference);
    }

    function normaliseUnits (units) {
        if (typeof units === 'undefined') {
            return 'ms';
        }

        if (units === 's' || units === 'ms') {
            return units;
        }

        throw new Error('Invalid units');
    }

    function normaliseTime (time, units, defaultTime) {
        if (typeof time === 'undefined') {
            return createTimeFrom(defaultTime);
        }

        if (typeof time === 'string') {
            time = parseInt(time, 10);
        }

        if (isNotDate(time) && isNotTimestamp(time)) {
            throw new Error('Invalid time');
        }

        if (typeof time === 'number' && units === 's') {
            time *= 1000;
        }

        return createTimeFrom(time);
    }

    function isNotDate (date) {
        return isDate(date) === false;
    }

    function isDate (date) {
        return Object.prototype.toString.call(date) === "[object Date]" && isNaN(date.getTime()) === false;
    }

    function isNotTimestamp (timestamp) {
        return isTimestamp(timestamp) === false;
    }

    function isTimestamp (timestamp) {
        return typeof timestamp === 'number' && isNaN(timestamp) === false;
    }

    function createTimeFrom (thing) {
        if (isDate(thing)) {
            return createTimeFromDate(thing);
        }

        if (isTimestamp(thing)) {
            return createTimeFromTimestamp(thing);
        }
    }

    function createTimeFromDate (date) {
        return createTime(date.getTime(), date);
    }

    function createTime (timestamp, date) {
        return {
            timestamp: timestamp,
            day: date.getDay(),
            week: getWeek(date),
            month: date.getMonth(),
            year: date.getYear()
        };
    }

    function getWeek (date) {
        var rollover = 0,
            yearStart = new Date(date.getFullYear(), 0, 1);

        if (yearStart.getDay() > date.getDay()) {
            rollover = 1;
        }

        return Math.floor((date.getTime() - yearStart.getTime()) / times.week) + rollover - 1;
    }

    function createTimeFromTimestamp (timestamp) {
        return createTime(timestamp, new Date(timestamp));
    }

    function estimate (difference, from, to) {
        if (difference === 0) {
            return 'now';
        }

        return estimateDay(difference, from, to) ||
            estimateWeek(difference, from, to) ||
            estimateMonth(difference, from, to) ||
            estimateYear(from, to);
    }

    function estimateDay (difference, from, to) {
        return estimatePeriod(difference, 'day', from, to, 'today', 'tomorrow', 'yesterday');
    }

    function estimatePeriod (difference, period, from, to, current, next, previous) {
        if (difference < times[period] * 2) {
            if (from[period] === to[period]) {
                return current;
            }

            if (areConsecutive(from[period], to[period], cardinalities[period])) {
                return next;
            }

            if (areConsecutive(to[period], from[period], cardinalities[period])) {
                return previous;
            }
        }
    }

    function areConsecutive (lesser, greater, cardinality) {
        return lesser === greater - 1 || (lesser === cardinality - 1 && greater === 0);
    }

    function estimateWeek (difference, from, to) {
        return estimateUniformPeriod(difference, 'week', from, to);
    }

    function estimateUniformPeriod (difference, period, from, to) {
        return estimatePeriod(difference, period, from, to, 'this ' + period, 'next ' + period, 'last ' + period);
    }

    function estimateMonth (difference, from, to) {
        return estimateUniformPeriod(difference, 'month', from, to);
    }

    function estimateYear (from, to) {
        if (from.year === to.year) {
            return 'this year';
        }

        if (from.year === to.year + 1) {
            return 'last year';
        }

        if (from.year === to.year - 1) {
            return 'next year';
        }
    }

    function getYearlyDifference(absoluteDifference, difference) {
        var years = Math.floor(absoluteDifference / times.year);

        if (difference < 0) {
            return 'in ' + years + ' years';
        }

        return years + ' years ago';
    }

    /**
     * Public function `set`.
     *
     * Returns a date instance representing a vague date.
     *
     * @param vagueDate {string} The vague date.
     */
    function setVagueDate (vagueDate) {
        // TODO: Give this function some thought.

        var date = new Date();

        switch (vagueDate) {
            case 'now':
                break;
            case 'today':
                setEndOfDay(date);
                break;
            case 'yesterday':
                date.setDate(date.getDate() - 1);
                setEndOfDay(date);
                break;
            case 'tomorrow':
                date.setDate(date.getDate() + 1);
                setEndOfDay(date);
                break;
            case 'last week':
                date.setDate(date.getDate() - 7);
                setEndOfDay(date);
                break;
            case 'next week':
                date.setDate(date.getDate() + 7);
                setEndOfDay(date);
                break;
            case 'last month':
                date.setMonth(date.getMonth() - 1);
                setEndOfDay(date);
                break;
            case 'next month':
                date.setMonth(date.getMonth() + 1);
                setEndOfDay(date);
                break;
            case 'last year':
                date.setYear(date.getYear() - 1);
                setEndOfDay(date);
                break;
            case 'next year':
                date.setYear(date.getYear() + 1);
                setEndOfDay(date);
                break;
            case 'whenever':
                date = new Date(0);
                break;
            default:
                throw new Error('Invalid vague date');
        }

        return date;
    }

    function setEndOfDay (date) {
        date.setHours(23);
        date.setMinutes(59);
        date.setSeconds(59);
        date.setMilliseconds(999);
    }
}());

