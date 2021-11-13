Commands := CommandSet clone do(
    asString := method($"<Commands: [#{self slotNames fmt}]>")
)

Commands do(
    defcmd(restart, ==("restart"), System exit(0))
    defcmd(cat, beginsWithSeq("cat"),
        arg := line split at(1)
        Paths currentDir fileNamed(arg) readLines foreach(x,
            actor out writeln(x)
        )
    )

    defcmd(cd, beginsWithSeq("cd"),
        args := line split slice(1)
        Paths cd(args at(0))
    )
    defcmd(pwd, ==("pwd"),
        actor out writeln(Paths currentDir path)
    )
    defcmd(ls, beginsWithSeq("ls"),
        fs := Paths
        arg := line split slice(1) at(0)
        if(arg isNil not, fs := fs cwd(arg))
        fs ls foreach(f,
            dirMarker := if(f isKindOf(Directory), "/", "")
            actor out writeln(f name .. dirMarker)
        )
    )

    defcmd(y, ==("objs"),
        WorldObject registry cleanUp map(link) foreach(x,
            if(x registry size > 0,

                actor out lexicalDo(
                    writeln(x type .. ":")
                    write("\t")
                    writeln(x registry map(link asString) fmt)
                )
            )
        )
    )

    defcmd(z, ==("z"),
        Quit raise("quit")
    )
)
