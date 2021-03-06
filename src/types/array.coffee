
class _Array extends Type
  @isType: (val, e) ->
    return true if Object.prototype.toString.call(val) is "[object Array]"
    e?.error = new Error("Expected #{val} to be an array")
    false

  isType: (val, e) ->
    return true if super(val, e)
    return false if not _Array.isType(val, e)
    if @options.length? and val.length isnt @options.length
      e?.error = new Error("Expected [#{val}] to have a length of #{@options.length}")
      return false
    true

  constructor: (options={}) ->
    if not (@ instanceof _Array) then return new _Array(options)
    super()
    @options = options

