
class Type
  constructor: ->
    @alternatives = []
  or: (type) ->
    @alternatives.push(type)
    @
  isType: (val) ->
    for type in @alternatives
      return true if type.isType(val)
    false
