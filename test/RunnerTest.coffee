Runner = require 'lib/Runner'
should = require 'should'
fs = require 'fs'

describe 'Runner', ->

  describe 'indentSource', ->

    input = "hello\nworld\n  how\n  are\n  you"
    actual = Runner.indentSource input, '-', 2

    it 'should indent correctly', ->

      actual.should.eql "--hello\n--world\n--  how\n--  are\n--  you"