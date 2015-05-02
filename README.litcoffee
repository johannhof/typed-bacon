# typed-bacon [![](https://travis-ci.org/johannhof/typed-bacon.svg)](https://travis-ci.org/johannhof/typed-bacon)
Type checks in your Bacon stream!

_This document is a source file that can be run and contains tests to stay up to date._

    assert = require('assert')

## Usage

Requiring Bacon before typed-bacon ensures that the custom methods can hook into Bacon correctly.

    Bacon = require('baconjs')

You will also want to require typed-bacon to get access to the Types object.

    {Types} = require('./typed-bacon.coffee')

## Example

    Bacon.fromArray([1,2,"3"])
         .typeCheck(Types.Number)
         .onError (e) ->
           assert.equal(e, "Expected 3 to be of type number.")

