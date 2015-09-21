bigInt = require "big-integer"

class Rat
    constructor: (num = 0, denom = 1) ->
        @num = new bigInt num
        @denom = new bigInt denom
        @normalize()
    normalize: ->
        throw new Error("Division by zero!!!") if @denom.isZero()
        if @num.isZero()
            @denom = new bigInt(1)
            return this
        if not @denom.isPositive()
            @num = bigInt.zero.minus(@num)
            @denom = bigInt.zero.minus(@denom)
            return @normalize()
        if not @num.isPositive()
            @num = bigInt.zero.minus(@num)
            @normalize()
            @num = bigInt.zero.minus(@num)
            return this
        g = bigInt.gcd @num, @denom
        @num = @num.divide g
        @denom = @denom.divide g
        return this

Rat.zero = ->
    new Rat 0, 1

Rat.add = (X,Y) ->
    X = new Rat X unless X instanceof Rat
    Y = new Rat Y unless Y instanceof Rat
    new Rat X.num.times(Y.denom).add(Y.num.times X.denom), X.denom.times Y.denom

Rat.minus = (X,Y) ->
    X = new Rat X unless X instanceof Rat
    if not Y?
        return new Rat bigInt.zero.minus(X.num), X.denom
    Y = new Rat Y unless Y instanceof Rat
    X.add Rat.minus Y

Rat.times = (X,Y) ->
    X = new Rat X unless X instanceof Rat
    Y = new Rat Y unless Y instanceof Rat
    new Rat X.num.times(Y.num), X.denom.times Y.denom

Rat.inverse = (X) ->
    throw new Error("Division by zero!!!") if X.num.isZero()
    return new Rat X.denom, X.num
Rat.divide = (X,Y) ->
    X = new Rat X unless X instanceof Rat
    Y = new Rat Y unless Y instanceof Rat
    Rat.times X, Rat.inverse Y

Rat.lesser = (X,Y) ->
    X = new Rat X unless X instanceof Rat
    Y = new Rat Y unless Y instanceof Rat
    X.num.times(Y.denom).lesser Y.num.times X.denom

Rat.leq = (X,Y) ->
    X = new Rat X unless X instanceof Rat
    Y = new Rat Y unless Y instanceof Rat
    X.num.times(Y.denom).leq Y.num.times X.denom

Rat.toNumber = (X) ->
    X.num.valueOf() / X.denom.valueOf()

Rat.eq = (X,Y) ->
    X = new Rat X unless X instanceof Rat
    Y = new Rat Y unless Y instanceof Rat
    X.num.eq(Y.num) and X.denom.eq(Y.denom)

Rat::zero = Rat.zero
Rat::add = (x) -> Rat.add this, x
Rat::minus = (x) -> Rat.minus this, x
Rat::times = (x) -> Rat.times this, x
Rat::inverse = -> Rat.inverse this
Rat::divide = (x) -> Rat.divide this, x
Rat::lesser = (x) -> Rat.lesser this, x
Rat::leq = (x) -> Rat.leq this, x
Rat::eq = (x) -> Rat.eq this, x
Rat::valueOf = -> Rat.toNumber this

module.exports = Rat
