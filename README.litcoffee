# typed-bacon [![](https://travis-ci.org/johannhof/typed-bacon.svg)](https://travis-ci.org/johannhof/typed-bacon)
Type checks in your Bacon stream!

_This document is a source file that can be run and contains tests to stay up to date._

    assert = require('assert')

## Usage

Requiring Bacon before typed-bacon ensures that the custom methods can hook into Bacon correctly.

    Bacon = require('baconjs')

You will also want to require typed-bacon to get access to the Types object.

    {Types} = require('./typed-bacon.coffee')

## Docs

### Observable.typeCheck

Transforms a value to an error if the input is not of the specified type.

    Bacon.fromArray([1, 2, "3"])
         .typeCheck(Types.Number)
         .onError (e) ->
           assert(e instanceof Error)
           assert.equal(e.message, "Expected 3 to be of type number.")

### Observable.typeFilter

Filters out all stream values that are not of the specified type.

    Bacon.fromArray([1, "2", 3, true, 4])
         .typeFilter(Types.Number)
         .slidingWindow(3,3)
         .onValue (arr) ->
           assert.deepEqual(arr, [1, 3, 4])

### Observable.typeWarn

### Types

#### Object

#### Array

