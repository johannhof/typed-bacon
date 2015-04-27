jest.dontMock '../typed-bacon.coffee'
jest.dontMock 'baconjs'

Bacon = require 'baconjs'
{Types} = require '../typed-bacon.coffee'

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
