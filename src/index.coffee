
init = (Bacon) ->
  Bacon.Observable :: typeFilter = (type) ->
    filter = @filter (val) -> type.isType(val)
    res = filter.withDescription(@, "typeFilter", type)

  Bacon.Observable :: typeCheck = (type) ->
    map = @flatMap (val) ->
      if type.isType(val)
        return val
      return new Bacon.Error(new Error("Expected #{val} to be of type #{type.description}."))
    res = map.withDescription(@, "typeCheck", type)

  Types:
    Existy:
      class Existy extends Type
        @description: "existy"
        @isType: (val) -> val?
        constructor: ->
          if not (@ instanceof Existy) then return new Existy()
          super()

    Null:
      class Null extends Type
        @description: "null"
        @isType: (val) -> val is null
        constructor: ->
          if not (@ instanceof Null) then return new Null()
          super()

    Boolean:
      class _Boolean extends Type
        @description: "boolean"
        @isType: (val) -> typeof val is 'boolean'
        constructor: ->
          if not (@ instanceof _Boolean) then return new _Boolean()
          super()

    Number:
      class _Number extends Type
        @description: "number"
        @isType: (val) -> typeof val is 'number'
        constructor: ->
          if not (@ instanceof _Number) then return new _Number()
          super()

    String:
      class _String extends Type
        @description: "string"
        @isType: (val) -> typeof val is 'string'
        constructor: ->
          if not (@ instanceof _String) then return new _String()
          super()

    Array: _Array
    Object: _Object
    Function:
      class _Function extends Type
        @description: "function"
        @isType: (val) ->
          typeof val is 'function'
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

