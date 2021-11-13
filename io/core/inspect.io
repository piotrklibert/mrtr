Inspector := Object clone do(
    inspect := method(what, what inspect)
)


Object do(
    isSubclass := method(cls,
        cls in(self ancestors)
    )
    isInstance := method(cls,
        self proto == cls
    )
    id := method(
        self type .. "@" .. self uniqueId
    )

    inspect := method(
        out := (Player currentPlayer ?out) whenNil(StdOut)
        colors := Colors with(out)
        colors fg("red") writeln(self id)
        self slotNames sort foreach(slot,
            meth := false
            slot := slot asString
            slotVal := method(self getSlot(slot))
            if(self getSlot(slot) type == "Block",
                meth := true
                colors fg("green") write("method ")
            )

            colors fg("yellow") write(slot .. ": ")
            if(slotVal == self,
                out writeln("<ref to self>")
                continue
            )
            out writeln(self getSlot(slot) asString)
            if(meth,
                out writeln("------------")
            )
            nil
        )
        nil
    )
)
