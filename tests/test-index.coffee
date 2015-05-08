jest.dontMock '../dist/typed-bacon'
jest.dontMock 'baconjs'

Bacon = require 'baconjs'
{Types} = require '../dist/typed-bacon'

describe 'or', ->
  it 'chains', ->
    expect(Types.Object().or(Types.Array).isType([])).toBe(true)
    expect(Types.Object().or(Types.Number).isType([])).toBe(false)

