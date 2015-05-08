
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

  Bacon.Observable :: typeWarn = (type, level="warn") ->
    warn = @doAction (val) ->
      e = {}
      if not type.isType(val, e)
        if console[level]
          console[level].call(null, e.error?.message)
    res = warn.withDescription(@, "typeWarn", type)

  Types:
    Existy: Existy
    Null: Null
    Boolean: _Boolean
    Number: _Number
    String: _String
    Array: _Array
    Object: _Object
    Function: _Function

if module? && module.exports?
  Bacon = require("baconjs")
  module.exports = init(Bacon)
else
  if typeof define == "function" and define.amd
    define ["bacon"], init
  else
    init(this.Bacon)

