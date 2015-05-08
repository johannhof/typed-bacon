class _Boolean extends Type
  @isType: (val, e) ->
    return true if typeof val is 'boolean'
    e?.error = new Error("Expected #{val} to be a boolean")
    false
  isType: (val, e) ->
    return true if super(val, e)
    return false if not _Boolean.isType(val, e)
    true
  constructor: ->
    if not (@ instanceof _Boolean) then return new _Boolean()
    super()

