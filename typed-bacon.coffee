
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

  class Type
    constructor: ->
      @alternatives = []
    or: (type) ->
      @alternatives.push(type)
      @
    isType: (val) ->
      for type in @alternatives
        return true if type.isType(val)
      false

  class _Array extends Type
    @description: "array"
    @isType: (val) ->
      Object.prototype.toString.call(val) is "[object Array]"

    isType: (val) ->
      return true if super(val)
      return false if not _Array.isType(val)
      return false if @options.length? and val.length isnt @options.length
      true

    constructor: (options={}) ->
      if not (@ instanceof _Array) then return new _Array(options)
      super()
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

  class _Object extends Type
    @description: "object"
    @isType: (val) ->
      Object.prototype.toString.call(val) is "[object Object]"

    isType: (val) ->
      return true if super(val)
      return false if not _Object.isType(val)
      deepIsType(@proto, val)

    constructor: (proto={}) ->
      if not (@ instanceof _Object) then return new _Object(proto)
      super()
      @proto = proto

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

