Chunk := Object clone do(

)

Description := Object clone do(
    defattr(chunks, Map clone)
    defattr(order, list("baseDesc"))

    asString := method(
        self order map(x, self chunks at(x) asString) join("\n")
    )

    compose := method(
        c := self clone
        arg := call argAt(0)
        c doMessage(arg, call sender)
        c
    )

    addSection := method(name,# aValue,
        if(call argAt(1) name beginsWithSeq("\""),
            strval := call evalArgAt(1)
        )
        self order append(name)
        self chunks atPut(name, strval)
    )
)

Description compose(
    addSection("baseDesc", "asdasdadsasd\nde242424")
    addSection("contDesc", "asdasda';';';dsasd\nde242424")
    addSection("blahDesc", "asd123134134asdadsasd\nde242424")
) asString println


Sequence asDescription := method(Description with(list(self)))
List asDescription := method(
    desc := Description clone
)
