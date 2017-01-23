foo := Object clone
foo do(
    defattr(attr, "ok")
)
foo2 := foo clone
foo2 attr

assert(foo _attr == nil)
foo attr

assert(foo attr ==("ok"))
assert(foo attr == "ok")

foo setAttr("z")
assert(foo attr == "z")

assert(foo2 attr == "ok")
foo2 setAttr("1")
assert(foo2 attr == "1")
assert(foo attr == "z")

a := WorldObject clone
b := WorldObject clone

assert(a environ == nil)
a setEnviron("ok")
assert(a environ == "ok")
