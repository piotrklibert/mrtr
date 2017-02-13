RoomExit := Object clone do(
    with := method(direction, destination,
        cln := self clone
        cln direction := direction
        cln destination := destination
        cln
    )

    leadsTo := method(where,
        if(self destination isKindOf(Sequence),
            self destination == where,
            self destination sourceFile relPath == where
        )
    )

    asString := method("<Exit: #{direction} to '#{destination}'>" interpolate)
)
