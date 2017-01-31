Sequence asDescription := method(Description withString(self))

Description := Object clone do(
    defattr(chunks, Map clone)
    defattr(order, list())
    defattr(object, nil)
    defattr(player, nil)


    asString := method(
        width := self player ?options width
        res := []
        self order foreach(x,
            desc := self object perform(self chunks at(x), self player, self)
            if(desc,
                res append(if(width, desc wrap(width), desc))
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
