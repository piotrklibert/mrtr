Player := Container inherit
Player appendProto(CommandSet)

PlayerOptions := Object clone do(
    width := 70
)

Player do(
    defattr(options, PlayerOptions clone)
    defattr(evalContext, nil)

    defdesc(
        addSection("baseDesc")
    )

    short := method(name)
    baseDesc := method("Oblesny potwor znany niewielu jako " .. self name .. ".")

    notifyEnvEnter := method(what, from,
        what := what name
        where := self env getExitTo(from ?file worldRelPath) ?dir
        if(where,
            self show($$(self env enterDesc)),
            self show($"#{what} pojawia sie w klebach dymu.")
        )
    )

    notifyEnvLeave := method(what, to,
        what := what name
        where := self env getExitTo(to ?file worldRelPath) ?dir
        if(where,
            self show($$(self env leaveDesc)),
            self show($"#{what} znika w klebach dymu.")
        )
    )

    findNearby := method(aName,
        self findAllNearby(aName) first
    )

    findAllNearby := method(aName,
        containers := list(self, self inventory, self env inventory)
        containers flatten unique select(
            short split at(-1) == aName
        )
    )

    others := method(self allOthers select(isKindOf(Player)))
    allOthers := method(self env inventory select(!= self))

    show := method(self out performWithArgList("writeln", call evalArgs); self)
    showOthers := method(
        self others map(performWithArgList("show", call evalArgs); self)
    )


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
        actor show($"Bierzesz #{what}.") showOthers(
            $"#{actor} bierze #{what}.")
    )

    defcmd(drop, beginsWithSeq("odloz"),
        what := line split at(1)
        self findNearby(what) moveTo(self env)
        actor show($"Odkladasz #{what}.") showOthers(
            $"#{actor} odklada #{what}.")
    )
    defcmd(inv, beginsWithSeq("i"),
        if(self inventory size == 0,
            actor show("Nie masz w tej chwili nic przy sobie.")
        ,
            actor show("Masz przy sobie: " .. actor inventory map(short) fmt .. ".")
        )
    )

    defcmd(sp, ==("sp"),
        writeln("dcsv df adf ad adg >>>>>>>>>>>>>>>>>>")
        self out writeln(self env desc forPlayer(self))
    )
    defcmd(emote, beginsWithSeq("emote"),
        msg := self name .. line asMutable removePrefix("emote")
        actor show(msg) showOthers(msg)

    )

    defcmd(destroyObj, beginsWithSeq("destroy"),
        arg := line split at(1)
        obj := actor findNearby(arg)
        actor show(
            $"Dematerializujesz #{obj short}"
        ) showOthers(
            $"Spoglada od niechcenia na #{obj short}, ktory natychmiast znika."
        )
        obj destroy
    )

    defcmd(loadObj, beginsWithSeq("load"),
        arg := line split at(1)
        arg := Paths currentDir fileNamed(arg) path
        Namespace loadFile(arg)
        actor show($"Ladowanie pliku '#{arg}'.") showOthers(
            $"#{actor name} mruczy cos pod nosem i nagle zdajesz sobie sprawe, ze cos sie zmienilo w '#{arg}'."
        )
    )

    defcmd(goto, beginsWithSeq("goto"),
        where := line split at(1)
        self moveTo(WorldObject registryFind(where))
    )

    defcmd(move, beginsWithSeq("move"),
        args := line split slice(1)
        what := actor find(args at(0)) first
        where := actor find(args at(1)) first
        what moveTo(where)
    )

    defcmd(ob, beginsWithSeq("ob"),
        what := line split slice(1) at(0)
        obj := actor findNearby(what)
        if(obj,
            actor out writeln(obj desc forPlayer(actor))
            return
        )
        desc := actor env items select(x,
            if(x name isKindOf(List), what in(x name), x name == what)
        ) first ?desc
        actor out writeln(desc ifNilEval("Obejrzyj co?"))
    )

    defcmd(cloneObj, beginsWithSeq("clone"),
        what := line split at(1)
        cls := WorldObject registry map(link) select(file ?baseName  == what) first
        cls ifNil(cls := actor findNearby(what))
        obj := cls makeNew
        obj setFile(cls class file)
        actor show(
            $"Koncentrujesz sie i wypowiadasz zaklecie, materializujac #{obj short}."
        ) showOthers(
            $"#{actor name} koncentruje sie i wypowiada zaklecie. Przed toba nagle pojawia sie #{obj short}"
        )
        obj moveTo(actor env)

    )

    defcmd(bang, beginsWithSeq("!"),
        self evalContext ifNil(
            self setEvalContext(thisContext clone)
        )
        ex := try(
            ctx := self evalContext
            ctx p := actor
            ctx here := actor env
            res := ctx doString(line asMutable removePrefix("!"))
            actor out writeln(res)
        )
        if(ex, actor out writeln(ex))
    )
)
