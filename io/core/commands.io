Commands := CommandSet clone do(
    asString := method($"<Commands: [#{self slotNames fmt}]>")
)

Commands do(
    defcmd(destroy, beginsWithSeq("destroy"),
        arg := line split at(1)
        actor findNearby(arg) destroy
    )
    defcmd(cat, beginsWithSeq("cat"),
        arg := line split at(1)
        Paths currentDir fileNamed(arg) readLines foreach(x,
            actor out writeln(x)
        )
    )
    defcmd(loadObj, beginsWithSeq("load"),
        arg := line split at(1)
        arg := Paths currentDir fileNamed(arg) path
        Namespace loadFile(arg)
    )

    defcmd(goto, beginsWithSeq("goto"),
        where := line split at(1)
        self playerObject moveTo(WorldObject registryFind(where))
    )

    defcmd(move, beginsWithSeq("move"),
        args := line split slice(1)
        what := actor find(args at(0)) first
        where := actor find(args at(1)) first
        what moveTo(where)
    )

    defcmd(ob, beginsWithSeq("ob"),
        what := line split slice(1) at(0)
        desc := actor findNearby(what) ?desc
        desc ifNil(
            desc := actor env items select(name == what) first ?desc
        )
        actor out writeln(desc ifNilEval("Obejrzyj co?"))
    )

    defcmd(cloneObj, beginsWithSeq("clone"),
        what := line split at(1)
        cls := WorldObject registry map(link) select(file baseName  == what) first
        cls ifNil(
            cls := actor findNearby(what)
        )
        cls makeNew moveTo(actor env)
    )
    defcmd(bang, beginsWithSeq("!"),
        ex := try(
            ctx := thisContext clone
            ctx p := actor
            res := ctx doString(line asMutable removePrefix("!"))
            actor out writeln(res)
        )
        if(ex, actor out writeln(ex))
    )
    defcmd(cd, beginsWithSeq("cd"),
        args := line split slice(1)
        Paths cd(args at(0))
    )
    defcmd(pwd, beginsWithSeq("pwd"),
        actor out(Paths currentDir path)
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

    defcmd(y, beginsWithSeq("a"),
        WorldObject registry removeBySel(link) map(link) foreach(x,
            if(x registry size > 0,
                actor out lexicalDo(
                    writeln(x type .. ":")
                    write("\t")
                    writeln(x registry removeBySel(link) clone map(link asString) fmt)
                )
            )
        )
    )

    defcmd(z, beginsWithSeq("z"),
        Quit raise("quit")
    )
)
