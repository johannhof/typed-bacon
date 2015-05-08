jest.dontMock '../typed-bacon.coffee'
jest.dontMock 'baconjs'

Bacon = require 'baconjs'
{Types} = require '../typed-bacon.coffee'

describe 'Types', ->
  describe 'existy', ->
    it 'finds if an object is existy', ->
      expect(Types.Existy.isType(null)).toBe(false)
      expect(Types.Existy.isType(undefined)).toBe(false)
      expect(Types.Existy.isType(0)).toBe(true)
      expect(Types.Existy.isType("")).toBe(true)

  describe 'null', ->
    it 'finds if an object is null', ->
      expect(Types.Null.isType(null)).toBe(true)
      expect(Types.Null.isType(undefined)).toBe(false)
      expect(Types.Null.isType(0)).toBe(false)
      expect(Types.Null.isType("")).toBe(false)

  describe 'boolean', ->
    it 'finds if an object is a boolean', ->
      expect(Types.Boolean.isType(false)).toBe(true)
      expect(Types.Boolean.isType(true)).toBe(true)

  describe 'number', ->
    it 'finds if an object is a number', ->
      expect(Types.Number.isType("1")).toBe(false)
      expect(Types.Number.isType(1)).toBe(true)
      expect(Types.Number.isType(1.023423)).toBe(true)

  describe 'array', ->
    it 'finds if an object is an array', ->
      expect(Types.Array.isType([])).toBe(true)
      expect(Types.Array.isType(['a'])).toBe(true)
      expect(Types.Array().isType([])).toBe(true)

    it 'compares the length', ->
      expect(Types.Array(length: 10).isType([])).toBe(false)
      expect(Types.Array(length: 10).isType([1,2,3,4,5,6,7,8,9,10])).toBe(true)

  describe 'object', ->
    it 'finds if an object is an object', ->
      expect(Types.Object.isType([])).toBe(false)
      expect(Types.Object.isType({})).toBe(true)

    it 'does deep comparisons', ->
      expect(Types.Object({test: Types.String}).isType({test: "abc"})).toBe(true)
      expect(Types.Object({wat: {test: Types.Number}}).isType({wat: {test: 1}})).toBe(true)

      expect(Types.Object({test: Types.String}).isType({test: 1})).toBe(false)
      expect(Types.Object({test: Types.String}).isType({})).toBe(false)

  describe 'or', ->
    it 'chains', ->
      expect(Types.Object().or(Types.Array).isType([])).toBe(true)
      expect(Types.Object().or(Types.Number).isType([])).toBe(false)

