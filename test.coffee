Rat = require "./"

one = new Rat 1
two = new Rat 2
onethird = new Rat 1, 3

bilionsOfTrillions = new Rat "1029283728171826282728272827282728272827282728272827281616160", "162536452727272863626262626253646464635551110001162635353618"

res1 = bilionsOfTrillions.add(7).times(onethird).minus(one).divide 2
res2 = bilionsOfTrillions.minus(-7).divide(3).add(-1).times(new Rat 1,2)
console.log "test 1 : #{if res1.eq(res2) then 'OK!' else 'FAILURE!!!'}"

res3 = Rat.divide(1,3).divide(3).times(9)

console.log "test 2 : #{if res3.eq(1) then 'OK!' else 'FAILURE'}"

