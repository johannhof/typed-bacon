class _Function extends Type
  @isType: (val, e) ->
    return true if typeof val is 'function'
    e?.error = new Error("Expected #{val} to be a function")
    false
  isType: (val, e) ->
    return true if super(val, e)
    return false if not _Function.isType(val, e)
    true
  constructor: ->
    if not (@ instanceof _Function) then return new _Function()
    super()

