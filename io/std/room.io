Room := Container inherit
Room appendProto(CommandSet)

Room do(
    defattr(exits, list())
    defattr(items, list())
    defattr(events, list())
    defattr(eventRunner, nil)
    defattr(shortName, "<shortName not set>")

    asString := method(
        "<Room: " ..  self file name  .. ">"
    )

    desc := method(
        d := resend
        res := ("===> " .. self file name .. "\n")
        res := res .. ("===] " .. ColorMgr colorizedString("red", shortName) .. "\n")
        res := res .. d .. "\n"
        res := res .. "Dostrzegasz wyjscia na: " .. self exits fmt
        res
    )
    containerDesc := "Znajduja sie tutaj: "

    addItem := method(aName, aDescription,
        self items append(Map clone with(
            "name", aName,
            "desc", aDescription
        ) asObject)
    )

    addEvent := method(time, desc,
        self events append(desc)
        self eventRunner ifNil(
            self setEventRunner(
                block(
                    randomEl := (self events size * Random value) floor
                    self inventory select(isKindOf(Player)) foreach(
                        out writeln(self events at(randomEl))
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

    addExit := method(dir, file,
        writeln("Adding exit #{dir} to #{file}" interpolate)
        self exits append(dir)
        target := call target
        action := block(cmd, actor,
            ex := try(
                fname := target getSlot(call message name) fname
                room := Room registry select(link ?file name == fname) first ?link
                if(room not,
                    room := Namespace loadWorldObj(fname)
                )
                actor moveTo(room)
                actor out writeln(room desc)
            )
            actor out writeln(ex asString)
        )
        action fname := file
        defcommand(
            ("go_" .. dir),
            "beginsWithSeq(\"#{dir}\")" interpolate asMessage,
            action
        )
        body := message(
            fname := getSlot(call message name)

        )
    )
)
