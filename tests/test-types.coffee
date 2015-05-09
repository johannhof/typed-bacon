jest.dontMock '../dist/typed-bacon'
jest.dontMock 'baconjs'

Bacon = require 'baconjs'
{Types} = require '../dist/typed-bacon'

describe 'Types', ->
  describe 'existy', ->
    it 'finds if an object is existy', ->
      e = {}
      expect(Types.Existy.isType(null, e)).toBe(false)
      expect(e.error.message).toEqual("Expected null to be existy")
      expect(Types.Existy.isType(undefined, e)).toBe(false)
      expect(e.error.message).toEqual("Expected undefined to be existy")
      expect(Types.Existy.isType(0)).toBe(true)
      expect(Types.Existy.isType("")).toBe(true)

  describe 'null', ->
    it 'finds if an object is null', ->
      e = {}
      expect(Types.Null.isType(null)).toBe(true)
      expect(Types.Null.isType(undefined, e)).toBe(false)
      expect(e.error.message).toEqual("Expected undefined to be null")
      expect(Types.Null.isType(0, e)).toBe(false)
      expect(e.error.message).toEqual("Expected 0 to be null")
      expect(Types.Null.isType("", e)).toBe(false)
      expect(e.error.message).toEqual("Expected  to be null")

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

