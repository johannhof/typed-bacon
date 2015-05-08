class _String extends Type
  @isType: (val, e) ->
    return true if typeof val is 'string'
    e?.error = new Error("Expected #{val} to be a string")
    false
  isType: (val, e) ->
    return true if super(val, e)
    return false if not _String.isType(val, e)
    true
  constructor: ->
    if not (@ instanceof _String) then return new _String()
    super()

