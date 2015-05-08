deepIsType = (proto, comp, e) ->
  for own key, val of proto
    if val.isType # TODO find a better way to find if Type object?
      return false if not val.isType(comp[key], e)
    else if typeof val is "object"
      return false if not deepIsType(val, comp[key], e)
    else
      return false
  true

class _Object extends Type
  @isType: (val, e) ->
    return true if Object.prototype.toString.call(val) is "[object Object]"
    e?.error = new Error("Expected #{val} to be an object")
    false

  isType: (val, e) ->
    return true if super(val)
    if not _Object.isType(val)
      e?.error = new Error("Expected #{val} to be an object")
      return false
    deepIsType(@proto, val, e)

  constructor: (proto={}) ->
    if not (@ instanceof _Object) then return new _Object(proto)
    super()
    @proto = proto
