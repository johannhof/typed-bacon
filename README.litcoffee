# typed-bacon [![](https://travis-ci.org/johannhof/typed-bacon.svg)](https://travis-ci.org/johannhof/typed-bacon) [![](https://img.shields.io/npm/v/typed-bacon.svg)](https://www.npmjs.com/package/typed-bacon)
Type checks in your Bacon stream!

```
npm install typed-bacon
```

> This document is an executable source file that contains tests to stay up to date.

    assert = require('assert')

## Usage

Requiring Bacon before typed-bacon ensures that the custom methods can hook into Bacon correctly.
You need to require `typed-bacon` to add the custom type methods to Bacon observables.
You will also want to get access to the Types object.

    Bacon = require('baconjs')
    {Types} = require('typed-bacon')

## API

### Observable.typeCheck

Transforms a value to an error if the input is not of the specified type.

    Bacon.fromArray([1, 2, "three"])
         .typeCheck(Types.Number)
         .onError (e) ->
           assert(e instanceof Error)
           assert.equal(e.message, "Expected three to be a number")

### Observable.typeFilter

Filters out all stream values that are not of the specified type.

    Bacon.fromArray([1, "two", 3, true, 4])
         .typeFilter(Types.Number)
         .slidingWindow(3,3)
         .onValue (arr) ->
           assert.deepEqual(arr, [1, 3, 4])

### Observable.typeWarn

Will warn about type mismatches but will not interfere with the stream

    # logs "Expected true to be a number"
    Bacon.fromArray([5, true, "test", null])
         .typeWarn(Types.Number().or(Types.Null).or(Types.String))
         .slidingWindow(4,4)
         .onValue (arr) ->
           assert.deepEqual(arr, [5, true, "test", null])

### Chaining types

Types can be chained using the `or` method.

    Bacon.fromArray([5, true, "test", null])
         .typeCheck(Types.Number().or(Types.Null).or(Types.String))
         .slidingWindow(3,3)
         .onValue (arr) ->
           assert.deepEqual(arr, [5, "test", null])

### Types.Object

Types.Object can be passed a JS object containing child types with infinite deepness(as long as the call stack holds).

    person = {
      name: "Johann",
      languages: 5
    }

    Bacon.once(person)
         .typeCheck(Types.Object({
           name: Types.String,
           languages: Types.Array
         }))
         .onError (e) ->
           assert(e instanceof Error)
           assert.equal(e.message, "Expected 5 to be an array")

### Types.Array

Types.Array can receive an object with a length parameter, specifying the exact length of the array.

    Bacon.once([1,2,3,4])
         .typeCheck(Types.Array(length: 5))
         .onError (e) ->
           assert(e instanceof Error)
           assert.equal(e.message, "Expected [1,2,3,4] to have a length of 5")

