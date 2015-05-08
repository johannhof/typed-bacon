class _Number extends Type
  @isType: (val, e) ->
    return true if typeof val is 'number'
    e?.error = new Error("Expected #{val} to be a number")
    false
  isType: (val, e) ->
    return true if super(val, e)
    return false if not _Number.isType(val, e)
    true
  constructor: ->
    if not (@ instanceof _Number) then return new _Number()
    super()

