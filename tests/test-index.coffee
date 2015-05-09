jest.dontMock '../dist/typed-bacon'
jest.dontMock 'baconjs'

Bacon = require 'baconjs'
{Types} = require '../dist/typed-bacon'

describe 'or', ->
  it 'chains', ->
    expect(Types.Object().or(Types.Array).isType([])).toBe(true)
    expect(Types.Object().or(Types.Number).isType([])).toBe(false)

  it 'tolerates duplicate chains', ->
    expect(Types.Object().or(Types.Number).or(Types.Number).isType([])).toBe(false)
    expect(Types.Object().or(Types.Number).or(Types.Number).isType(1)).toBe(true)
    expect(Types.Object().or(Types.Number).or(Types.Number).isType({})).toBe(true)

