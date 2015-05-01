
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

  class _Array
    @description: "array"
    @isType: (val) ->
      Object.prototype.toString.call(val) is "[object Array]"

    isType: (val) ->
      return false if not _Array.isType(val)
      return false if @options.length? and val.length isnt @options.length
      true

    constructor: (options={}) ->
      if not (@ instanceof _Array) then return new _Array(options)
      @options = options

  deepIsType = (proto, comp) ->
    for own key, val of proto
      if val.isType # TODO find a better way to find if Type object?
        return false if not val.isType(comp[key])
      else if typeof val is "object"
        return false if not deepIsType(val, comp[key])
      else
        return false
    true

  class _Object
    @description: "object"
    @isType: (val) ->
      Object.prototype.toString.call(val) is "[object Object]"

    isType: (val) ->
      return false if not _Object.isType(val)
      return deepIsType(@proto, val)

    constructor: (proto={}) ->
      if not (@ instanceof _Object) then return new _Object(proto)
      @proto = proto

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
    Array: _Array
    Object: _Object
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

