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
        Colors fg("red") writeln(self id)
        self slotNames sort foreach(slot,
            meth := false
            slot := slot asString
            slotVal := method(self getSlot(slot))
            if(self getSlot(slot) type == "Block",
                meth := true
                Colors fg("green") write("method ")
            )

            Colors fg("yellow") write(slot .. ": ")
            if(slotVal == self,
                writeln("<ref to self>")
                continue
            )
            writeln(self getSlot(slot) asString)
            if(meth,
                "------------" println
            )
            nil
        )
    )
)
