
gcd = (a, b) ->
    return a if b is 0
    gcd b, a % b


class Rat
    constructor: (@num = 0, @denom = 1) ->
        @normalize()
    normalize: ->
        throw new Error("Division by zero!!!") if @denom is 0
        if @num is 0
            @denom = 1
            return this
        if @denom < 0
            @num = -@num
            @denom = -@denom
            return @normalize()
        if @num < 0
            @num = -@num
            @normalize()
            @num = -@num
            return this
        g = gcd @num, @denom
        @num = @num // g
        @denom = @denom // g
        return this

Rat.zero = ->
    new Rat 0, 1

Rat.add = (X,Y) ->
    X = new Rat X unless X instanceof Rat
    Y = new Rat Y unless Y instanceof Rat
    new Rat (X.num * Y.denom) + (Y.num * X.denom), X.denom * Y.denom
Rat.minus = (X,Y) ->
    X = new Rat X unless X instanceof Rat
    if not Y?
        return new Rat -X.num, X.denom
    Y = new Rat Y unless Y instanceof Rat
    X.add Rat.minus Y

Rat.times = (X,Y) ->
    X = new Rat X unless X instanceof Rat
    Y = new Rat Y unless Y instanceof Rat
    new Rat X.num * Y.num, X.denom * Y.denom

Rat.inverse = (X) ->
    throw new Error("Division by zero!!!") if X.num is 0
    return new Rat X.denom, X.num

Rat.divide = (X,Y) ->
    X = new Rat X unless X instanceof Rat
    Y = new Rat Y unless Y instanceof Rat
    Rat.times X, Rat.inverse Y

Rat.lesser = (X,Y) ->
    X = new Rat X unless X instanceof Rat
    Y = new Rat Y unless Y instanceof Rat
    X.num * Y.denom < Y.num * X.denom

Rat.leq = (X,Y) ->
    X = new Rat X unless X instanceof Rat
    Y = new Rat Y unless Y instanceof Rat
    X.num * Y.denom <= Y.num * X.denom

Rat.toNumber = (X) ->
    X.num / X.denom

Rat.eq = (X,Y) ->
    X = new Rat X unless X instanceof Rat
    Y = new Rat Y unless Y instanceof Rat
    (X.num is Y.num) and (X.denom is Y.denom)

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
