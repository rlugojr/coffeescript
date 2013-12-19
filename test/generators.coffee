# Generators
# -----------------
#
# * Generator Definition

# Using the keyword yield should not cause a syntax error.
->* yield 0

test "Generator Definition", ->
  x = ->*
    yield 0
    yield 1
    yield 2
  y = x()
  z = y.next()
  eq z.value, 0
  eq z.done, false
  z = y.next()
  eq z.value, 1
  eq z.done, false
  z = y.next()
  eq z.value, 2
  eq z.done, false
  z = y.next()
  eq z.value, undefined
  eq z.done, true

test "bound generator", ->
  obj =
    bound: ->
      do =>*
        this
      .next().value
    unbound: ->
      do ->*
        this
      .next().value
    nested: ->
      do =>*
        do =>*
          do =>*
            this
          .next().value
        .next().value
      .next().value

  eq obj, obj.bound()
  ok obj isnt obj.unbound()
  eq obj, obj.nested()
