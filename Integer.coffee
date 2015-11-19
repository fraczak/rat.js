
class Integer
    constructor: (num = 0) ->
        if num.val?
            @val = num.val
        else
            @val = num
    zero: new Integer()
    isZero: ->
        @val is 0
    isPositive: ->
        @val > 0
    minus: (y) ->
        y = new Integer(y) unless y instanceof Integer
        new Integer(@val - y.val)
    divide: (y) ->
        y = new Integer(y) unless y instanceof Integer
        new Integer(@val // y.val)
    times: (y) ->
        y = new Integer(y) unless y instanceof Integer
        new Integer(@val * y.val)
    add: (y) ->
        y = new Integer(y) unless y instanceof Integer
        new Integer(@val + y.val)
    valueOf: ->
        @val
    eq: (y) ->
        y = new Integer(y) unless y instanceof Integer
        @val is y.val

Integer::gcd = gcd = (x,y) ->
    return gcd(y,x) if x < y
    r = x %% y
    return y if r is 0
    gcd y, r


module.exports = Integer
