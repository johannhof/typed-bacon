class Existy extends Type
  @description: "existy"
  @isType: (val, e) ->
    return true if val?
    e?.error = new Error("Expected #{val} to be existy")
    false
  isType: (val, e) ->
    return true if super(val, e)
    return false if not Existy.isType(val, e)
    true
  constructor: ->
    if not (@ instanceof Existy) then return new Existy()
    super()
