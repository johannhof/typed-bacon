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
