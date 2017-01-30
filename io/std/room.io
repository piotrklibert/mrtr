Room := Container inherit
Room appendProto(CommandSet)

Room do(
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
            self exitsDesc .. self exits map(dir) fmt)
    )

    titleString := method(actor,
        fname := ColorMgr colorizedString("red", $"[#{self file relPath}]")
        ColorMgr colorizedString("yellow", $">>> #{short} #{fname}")
    )

    asString := method("<Room: " ..  self file ?name  .. ">")

    getExitTo := method(exitTo, self exits detect(file == exitTo))


    addItem := method(aName, aDescription,
        self items append(Map clone with(
            "name", aName,
            "desc", aDescription dedentIfNeeded
        ) asObject)
    )


    addEvent := method(time, desc,
        self events append(desc)
        self eventRunner ifNil(
            self setEventRunner(
                block(
                    randomEl := (self events size * Random value) floor
                    self inventory select(isKindOf(Player)) foreach(p,
                        p out writeln(self events at(randomEl) asDescription forPlayer(p))
                    )
                    if(self eventRunner,
                        wait(time + (Random value * 10))
                        self eventRunner @call)
                )
            )
            block(
                wait(10);
                self eventRunner call
            ) @call
        )
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
        writeln($"Adding exit #{dir} to #{file}")
        self exits append(Map with(
            "dir", dir, "file", file, asString(method(dir))
        ) asObject)
        target := call target
        action := block(cmd, actor,
            ex := try(
                fname := target getSlot(call message name) fname
                room := Room registry select(link ?file relPath == ("world/" .. fname)) first ?link
                if(room not,
                    room := Namespace loadWorldObj(fname)
                )
                actor moveTo(room)
                actor show(room desc forPlayer(actor))
            )
            ex catch(
                actor show(ex coroutine backTraceString)
            )
        )
        action fname := file

        defcommand(
            ("go_" .. dir),
            block(line, line == dir),
            action
        )
        body := message(
            fname := getSlot(call message name)

        )
    )
)
