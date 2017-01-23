Player := Container inherit
Player appendProto(CommandSet)

Player do(
    name := "Player proto"
    baseDesc := "A player without description."
)

Player do(
    setSocket := method(aSocket, self setOut(BaseWriter forSocket(aSocket)))
    baseDesc := method(
        "Oblesny potwor znany niewielu jako " .. self name .. "."
    )
    desc := method(
        WorldObject getSlot("desc") clone setScope(self) call
    )

    notifyArrived := method(what,
        out writeln(what name, " przybywa z ", what comingFrom ?file name)
    )

    notifyGone := method(what,
        out writeln(what name, " podaza do ", what goingTo ?file name)
    )

    findAllNearby := method(aName,
        containers := list(self, self inventory, self environ inventory)
        containers flatten unique select(name == aName)
    )
    findNearby := method(aName, self findAllNearby(aName) first)

    defcmd(sp, beginsWithSeq("sp"),
        self out writeln(self environ desc)
    )
    defcmd(emote, beginsWithSeq("emote"),
        msg := line asMutable removePrefix("emote")
        self environ inventory select(isKindOf(Player)) foreach(
            out writeln(self name .. msg)
        )

    )
)
