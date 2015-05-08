
init = (Bacon) ->
  Bacon.Observable :: typeFilter = (type) ->
    filter = @filter (val) -> type.isType(val)
    res = filter.withDescription(@, "typeFilter", type)

  Bacon.Observable :: typeCheck = (type) ->
    map = @flatMap (val) ->
      e = {}
      if type.isType(val, e)
        return val
      return new Bacon.Error(e.error)
    res = map.withDescription(@, "typeCheck", type)

  Types:
    Existy:
      class Existy extends Type
        @description: "existy"
        @isType: (val, e) ->
          return true if val?
          e?.error = new Error("Expected #{val} to be existy")
          false
        constructor: ->
          if not (@ instanceof Existy) then return new Existy()
          super()

    Null:
      class Null extends Type
        @isType: (val, e) ->
          return true if val is null
          e?.error = new Error("Expected #{val} to be null.")
          false
        constructor: ->
          if not (@ instanceof Null) then return new Null()
          super()

    Boolean:
      class _Boolean extends Type
        @isType: (val, e) ->
          return true if typeof val is 'boolean'
          e?.error = new Error("Expected #{val} to be a boolean")
          false
        constructor: ->
          if not (@ instanceof _Boolean) then return new _Boolean()
          super()

    Number:
      class _Number extends Type
        @isType: (val, e) ->
          return true if typeof val is 'number'
          e?.error = new Error("Expected #{val} to be a number")
          false
        constructor: ->
          if not (@ instanceof _Number) then return new _Number()
          super()

    String:
      class _String extends Type
        @isType: (val, e) ->
          return true if typeof val is 'string'
          e?.error = new Error("Expected #{val} to be a string")
          false
        constructor: ->
          if not (@ instanceof _String) then return new _String()
          super()

    Array: _Array
    Object: _Object
    Function:
      class _Function extends Type
        @isType: (val, e) ->
          return true if typeof val is 'function'
          e?.error = new Error("Expected #{val} to be a function")
          false
        constructor: ->
          if not (@ instanceof _Function) then return new _Function()
          super()


if module? && module.exports?
  Bacon = require("baconjs")
  module.exports = init(Bacon)
else
  if typeof define == "function" and define.amd
    define ["bacon"], init
  else
    init(this.Bacon)

