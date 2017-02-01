Room := Container inherit
Room appendProto(CommandSet)

Room do(
    debugOn()

    defattr(exits, list())
    defattr(items, list())
    defattr(events, list())
    defattr(eventRunner, nil)

    exitsDesc ::= nil
    enterDesc ::= nil
    leaveDesc ::= nil

    defdesc(
        addSection("header", "titleString")
        addSection("long")
        addSection("exits", "exitsString")
        addSection("contents", "contentsString")
    )

    setShort("podstawowy eteryczny pokoj")
    setContainerDesc("Znajduja sie tutaj: ")
    setExitsDesc(ColorMgr colorizedString("yellow", "Dostrzegasz wyjscia na: "))

    setLeaveDesc("#{what} podaza na #{where}.")
    setEnterDesc("#{what} przybywa z #{where}.")


    setLong("
        Ledwie widoczna, prawie calkiem przezroczysta z lekkim odcieniem blekitu
        powierzchnia jest tutaj odpowiednikiem podlogi. Brak widocznych scian i
        sufitu sprawia, ze otaczajace platforme geste, biale obloki sa doskonale
        widoczne. Miejsce to przywodzi na mysl spacer w chmurach, ale brak
        Slonca zdaje sie przeczyc temu wrazeniu: choc jest bardzo jasno, swiatlo
        pochodzi jakby z samych oblokow.
    ")

    contentsString := method(actor,
        contents := actor allOthers map(short)
        if(contents size > 0,
            contents fmt)
    )

    exitsString := method(
        if(self exits size > 0,
            self exitsDesc .. self exits map(direction) fmt)
    )

    titleString := method(actor,
        fname := ColorMgr colorizedString("red", $"[#{self sourceFile relPath}]")
        ColorMgr colorizedString("yellow", $">>> #{short} #{fname}")
    )

    asString := method($"<Room: '#{self sourceFile ?relPath}'>")

    getExitTo := method(exitTo, self exits detect(sourceFile relPath == exitTo))

    destroy := method(
        debugWriteln($"Room: destroying instance: ${self sourceFile relPath}")
        self setEventRunner(nil)
        resend
    )

    addItem := method(aName, aDescription,
        self items append(ObjectDetail with(aName, aDescription))
    )

    announce := method(what,
        self inventory select(isKindOf(Player)) foreach(p,
            p show(what asDescription forPlayer(p))
        )
    )

    playEvent := method(
        self announce(self events anyOne)
    )

    addEvent := method(time, desc,
        self events append(desc)
        self eventRunner ifNil(self setEventRunner(EventRunner with(self)))
    )

    addAction := method(predData, descriptions,
        if(predData isKindOf(Sequence), predData := list(predData))
        name := predData at(0) asMutable replaceSeq(" ", "_") asString
        pred := block(line, line beginsWithAnyOf(predData))

        action := block(line, actor,
            actor show($$(descriptions at(0)))
            if(descriptions size > 1,
                actor showOthers($$(descriptions at(1)))
            )
        )
        call sender defcommand(name, pred, action)
    )

    addExit := method(dir, file,
        debugWriteln($"Adding exit #{dir} to #{file}")
        currentExit := RoomExit with(dir, file)
        self exits append(currentExit)
        target := call target
        action := block(cmd, actor,
            ex := try(
                fname := "world/" .. file
                Namespace ensureLoaded(fname)
                room := Room registry cleanUp map(link) detect(sourceFile relPath == fname)

                actor moveTo(room)
                actor show(room desc forPlayer(actor))
                currentExit destination := room
            )
            ex catch(
                actor show(ex coroutine backTraceString)
            )
        )

        defcommand(
            ("go_" .. dir),
            block(line, line == dir),
            action
        )
        # body := message(
        #     fname := getSlot(call message name)
        # )
    )
)
