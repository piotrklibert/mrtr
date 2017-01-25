Player := Container inherit
Player appendProto(CommandSet)

Player do(
    baseDesc := "A player without description."
)

Player do(
    baseDesc := method(
        "Oblesny potwor znany niewielu jako " .. self name .. "."
    )

    desc := method(
        WorldObject getSlot("desc") clone setScope(self) call
    )

    # notifyArrived := method(what, ...)
    # out writeln(what name, " przybywa z ", what comingFrom ?file name)
    # notifyGone := method(what, ...)
    # out writeln(what name, " podaza do ", what goingTo ?file name)


    findAllNearby := method(aName,
        containers := list(self, self inventory, self env inventory)
        containers flatten unique select(name == aName)
    )

    findNearby := method(aName, self findAllNearby(aName) first)

    #
    # Commands
    #
    defcmd(say, beginsWithSeq("'"),
        line := line asMutable removePrefix("'") strip
        if(line size  == 0,
            actor out writeln("W ostatniej chwili decydujesz sie nic nie mowic.")
            actor env inventory select(x,
                x isKindOf(Player) and (x != actor)
            ) foreach(
                out writeln($"#{actor name} decyduje sie nic nie mowic.")
            )
        ,
            actor out writeln("Mowisz: ", line)
            actor env inventory select(x,
                x isKindOf(Player) and (x != actor)
            ) foreach(
                out writeln(actor name, " mowi: ", line)
            )
        )
    )

    defcmd(get, beginsWithSeq("wez"),
        what := line split at(1)
        self findNearby(what) moveTo(self)
    )

    defcmd(sp, beginsWithSeq("sp"),
        self out writeln(self env desc)
    )
    defcmd(emote, beginsWithSeq("emote"),
        msg := line asMutable removePrefix("emote")
        self env inventory select(isKindOf(Player)) foreach(
            out writeln(self name .. msg)
        )

    )
)
