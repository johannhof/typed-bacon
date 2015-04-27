
init = (Bacon) ->
  Bacon.Observable :: typeFilter = (types...) ->
    filter = @filter (val) ->
      for type in types
        return true if type.isType(val)
    res = filter.withDescription(@, "typeFilter", types)

  Bacon.Observable :: typeCheck = (types...) ->
    map = @map (val) ->
      for type in types
        if type.isType(val)
          return val
      throw new Error("Expected #{val} to be of type #{type.description}.")
    res = map.withDescription(@, "typeCheck", types)

  class Array
    @description: "array"
    @isType: (val) ->
      Object.prototype.toString.call(val) is "[object Array]"

  Types:
    Existy:
      description: "existy"
      isType: (val) -> val?
    Null:
      description: "null"
      isType: (val) -> val is null
    Boolean:
      description: "boolean"
      isType: (val) -> typeof val is 'boolean'
    Number:
      description: "number"
      isType: (val) -> typeof val is 'number'
    String:
      description: "string"
      isType: (val) -> typeof val is 'string'
    Array: Array
    Object:
      description: "object"
      isType: (val) ->
        Object.prototype.toString.call(val) is "[object Object]"
    Function:
      description: "function"
      isType: (val) ->
        typeof val is 'function'


if module? && module.exports?
  Bacon = require("baconjs")
  module.exports = init(Bacon)
else
  if typeof define == "function" and define.amd
    define ["bacon"], init
  else
    init(this.Bacon)

