class Null extends Type
  @isType: (val, e) ->
    return true if val is null
    e?.error = new Error("Expected #{val} to be null")
    false
  isType: (val, e) ->
    return true if super(val, e)
    return false if not Null.isType(val, e)
    true
  constructor: ->
    if not (@ instanceof Null) then return new Null()
    super()
