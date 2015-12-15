# rat.js
A javascript port of my Erlang RATional numbers library,
supporting + (add), - (minus), * (times), and / (divide).

The code was using 'big-integer' javascript library, but I want
it to work in Nashorn, so I switched to "BigInt"...

To install, do

        npm install rat.js

To use, do (in coffee-script):

        Rat = require "rat.js"

        one = Rat.divide(1, 3*7*11*51).times(3).times(7).times(11).times(51)
        # > { [Number: 1]
        # { [Number: 1]
        #   num: { [Number: 1] neg: false, val: [ 1, 0, 0, 0 ] },
        #   denom: { [Number: 1] neg: false, val: [ 1, 0, 0, 0 ] } }
        one.eq 1
        # > true



