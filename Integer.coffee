BigInt = require "BigInt"

class Integer
    constructor: (num=0, @neg=false) ->
        if num instanceof Integer
            @val = BigInt.dup num.val
            if @neg
                @neg = not num.neg
            else
                @neg = num.neg
        else if 'string' is typeof num
            if '-' is num.charAt 0
                num = num.slice 1
                @neq = not @neg
            @val = BigInt.str2bigInt num, 10, 0, 0
        else if 'number' is typeof num
            if num < 0
                num = - num
                @neg = not @neg
            @val = BigInt.int2bigInt num, 0, 0
        else
            @val = BigInt.dup num
    isZero: ->
        BigInt.isZero @val
    isNegative: ->
        @neg
    isPositive: ->
        return false if this.isZero()
        return false if @neg
        true
    ge: (y) ->
        y = new Integer(y) unless y instanceof Integer
        if @neg
            return false unless y.neg
            return true if 1 is BigInt.equals @val, y.val
            BigInt.greater y.val, @val
        else
            return true if y.neg
            return true if 1 is BigInt.equals @val, y.val
            BigInt.greater @val, y.val
    "-": ->
        new Integer @val, not @neg
    add: (y) ->
        y = new Integer(y) unless y instanceof Integer
        if @neg is y.neg
            return new Integer BigInt.add(@val, y.val), @neg
        if 1 is BigInt.greater @val, y.val
            delta = BigInt.sub(@val, y.val)
            return new Integer delta, @neg
        else
            delta = BigInt.sub(y.val, @val)
            return new Integer delta, y.neg
    minus: (y) ->
        y = new Integer(y) unless y instanceof Integer
        @add y['-']()
    divide: (y) ->
        neg = @neg isnt y.neg
        y = new Integer(y) unless y instanceof Integer
        q = BigInt.expand @val, y.val.length
        r = BigInt.dup q
        BigInt.divide_ @val, y.val, q, r
        new Integer q, neg
    times: (y) ->
        neg = @neg isnt y.neg
        y = new Integer(y) unless y instanceof Integer
        new Integer BigInt.mult(@val, y.val), neg
    valueOf: ->
        prefix = if @neg then "-" else ""
        str = prefix + BigInt.bigInt2str(@val,10)
        parseInt str, 10
    eq: (y) ->
        y = new Integer(y) unless y instanceof Integer
        if @isZero()
            return y.isZero()
        if BigInt.equals(@val, y.val) and @neg is y.neg
            return true
        false
Integer.gcd = gcd = (x,y) ->
    x = new Integer(x) unless x instanceof Integer
    y = new Integer(y) unless y instanceof Integer
    l = Math.max x.val.length, y.val.length
    new Integer BigInt.GCD BigInt.expand(x.val,l), BigInt.expand(y.val,l)
Integer.zero = new Integer(0)


module.exports = Integer
