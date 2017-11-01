foo := Object clone
foo do(
    defattr(attr, "init")
    defattr(attr2, "", dedent)
    defattr(a3, "", block(x, "q" .. x .. "q"))
)
s := "
    d
"


assert(foo a3 == "")
foo setA3(s dedent)
assert(foo a3 == "qdq")


assert(foo attr2 == "")
foo setAttr2(s)
assert(foo attr2 == s dedent)


foo2 := foo clone
assert(foo hasLocalSlot("_attr") not)
assert(foo2 hasLocalSlot("_attr") not)

foo attr
assert(foo attr == "init")

foo setAttr("z")
assert(foo attr == "z")
assert(foo2 attr == "init")

foo2 setAttr("1")
assert(foo attr == "z")
assert(foo2 attr == "1")

removeSlot("foo")
removeSlot("foo2")
