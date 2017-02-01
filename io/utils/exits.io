RoomExit := Object clone do(
    with := method(direction, destination,
        cln := self clone
        cln direction := direction
        cln destination := destination
        cln
    )
    asString := method("<Exit: #{direction} to '#{destination}'>" interpolate)
)
