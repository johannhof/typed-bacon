# typed-bacon [![](https://travis-ci.org/johannhof/typed-bacon.svg)](https://travis-ci.org/johannhof/typed-bacon)
Type checks in your Bacon stream!

    jest.dontMock '../typed-bacon.coffee'

    Bacon = require 'baconjs'
    {Types} = require '../typed-bacon.coffee'

    describe 'Types', ->
      describe 'existy', ->
        it 'finds if an object is existy', ->
          expect(Types.Existy.isType(null)).toBe(false)
          expect(Types.Existy.isType(undefined)).toBe(false)
          expect(Types.Existy.isType(0)).toBe(true)
          expect(Types.Existy.isType("")).toBe(true)

