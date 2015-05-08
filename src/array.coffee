
class _Array extends Type
  @description: "array"
  @isType: (val) ->
    Object.prototype.toString.call(val) is "[object Array]"

  isType: (val) ->
    return true if super(val)
    return false if not _Array.isType(val)
    return false if @options.length? and val.length isnt @options.length
    true

  constructor: (options={}) ->
    if not (@ instanceof _Array) then return new _Array(options)
    super()
    @options = options

