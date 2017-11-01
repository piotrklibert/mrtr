BaseWriter := Object clone do(
    defattr(file, nil)

    colorWrite := method(
        args := call evalArgs
        color := args at(0)
        args := args slice(1)
        self write(ColorMgr makeControlString(color))
        args foreach(a,
            self write(a)
        )
        self write(ColorMgr makeControlString("default"))
    )
    colorWriteln := method(
        self performWithArgList("colorWrite", call evalArgs)
        self write("\n")
    )
    write := method(
        call evalArgs foreach(x, self file write(x asString))
    )
    writeln := method(
        self performWithArgList("write", call evalArgs)
        self write("\n")
    )
)

SocketWriter := BaseWriter clone do(
    withSocket := method(aSocket,
        w := BaseWriter clone
        w setFile(aSocket)
        w
    )
    with := getSlot("withSocket")
)

StdOut := BaseWriter clone do(
    clone := method(StdOut)
    setFile(File standardOutput)
)

StdErr := BaseWriter clone do(
    clone := method(StdErr)
    setFile(File standardError)
)
