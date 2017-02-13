Object defdesc := method(
    msg := call argAt(0)
    ctx := call sender
    desc := Description clone
    desc doMessage(msg, ctx)
    ctx setDescriptionFormatter(desc)
    desc
)

Sequence asDescription := method(
    Description withString(self)
)


# @doc
# A Description objects are intermediaries between raw text strings and their
# display.
#
# To work, Description needs three things: a list of slot names, an object which
# provides some values under these slots (a source), and an object which wants
# to see the description (a target, almost always an instance of Player).
#
# Description takes care of formatting the output according to options provided
# by the player object.
#
# Example:
#
# obj := Object clone do(something := "Some text")
# Description withSections(["something"]) forObject(obj) forPlayer(Object clone)
#
# @end
Description := Object clone do(
    defattr(order, list())
    defattr(chunks, Map clone)

    defattr(object, nil)
    defattr(player, nil)


    asString := method(
        width := self player ?options width
        res := []
        self order foreach(x,
            desc := self object perform(self chunks at(x), self player, self)
            if(desc,
                res append(desc wrap(width))
            ,
                debugWriteln($"Chunk '#{x}' of #{self object} returned nil or false.")
            )
        )
        res join("\n")
    )

    addSection := method(name, optionalSelector,
        arg1 := optionalSelector
        arg1 ifNil(arg1 := name)
        self order append(name)
        self chunks atPut(name, arg1)
        self setSlot(
            name, method(
                msg := call message clone
                msg appendArg(message(self player))
                self object doMessage(msg, thisContext)
            )
        )
    )

    withSections := method(sections,
        cln := self clone
        sections foreach(s, cln addSection(s))
        cln
    )

    withString := method(aString,
        c := self clone
        c setObject(aString)
        c addSection("1", "yourself")
        c
    )

    forPlayer := method(obj,
        c := self clone
        self slotNames select(beginsWithSeq("_")) foreach(name,
            c setSlot(name, self getSlot(name))
        )
        c setPlayer(obj)
        c
    )

    forObject := method(obj,
        c := self clone
        self slotNames select(beginsWithSeq("_")) foreach(name,
            c setSlot(name, self getSlot(name))
        )
        c setObject(obj)
        c
    )
)
