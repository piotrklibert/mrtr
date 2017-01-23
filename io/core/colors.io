ColorMgr := Object clone do(

    withColor := method(aColor,
        c := self clone
        c color := aColor
        c
    )
    with := method(out,
        c := self clone
        c out := out
        c
    )
    out := nil
    colorsMap := Map with(
        "default", 9, "black", 0,
        "red",     1, "green", 2,
        "yellow",  3, "blue",  4,
        "magenta", 5, "cyan",  6,
        "white",   7
    )
    controlSeqBeg := "[0;3"
    controlSeqEnd := "m"
    makeControlString := method(color,
        controlSeqBeg .. colorsMap at(color) asString .. controlSeqEnd
    )

    colorizedString := method(
        if(call message arguments size == 2,
            color := call evalArgAt(0)
            obj := call evalArgAt(1)
        ,
            color := self color
            obj := call evalArgAt(0)
        )
        makeControlString(color) .. obj asString .. makeControlString("default")
    )
    write := method(obj,
        out write(self colorizedString(obj))
    )
    writeln := method(obj,
        self write(obj)
        out write("\n")
    )
)


Colors := Object clone do(
    with := method(anOutputChannel,
        c := self clone
        if(anOutputChannel,
            c out := anOutputChannel
        ,
            c out := StdOut
        )
        c
    )
    fg := method(c,
        mgr := ColorMgr with(self out)
        mgr color := c
        mgr
    )
)
