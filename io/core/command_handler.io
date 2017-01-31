BaseCommandHandler := Object clone do(
    defattr(lastCommand, nil)
    defattr(commands, nil)
    defattr(player, nil)


    destroy := method(
        self player destroy
    )

    asString := method($"[commands=#{commands};player=#{player}]")

    commandSets := method(
        p := self player
        list(
            p, p inventory, p env, p env inventory, self commands
        ) flatten unique select(isKindOf(CommandSet))
    )

    doCommand := method(commandLine,
        commandLine ifNil(Quit raise("EOF"))
        self setLastCommand(commandLine)
        found := false

        commandSets foreach(cs,
            matchedAction := cs getCmdHandler(commandLine)
            if(matchedAction isNil not,
                writeln(self player, " is performing cmd: ", commandLine, " <> ", matchedAction)
                _performAction(cs, matchedAction, commandLine)
                found := true
                break
            )
        )
        if(found not,
            self player show("Slucham?")
        )
        self displayPrompt
    )

    displayPrompt := method(
        self player out write("> ")
    )

    _performAction := method(cmdObj, actionName, cmdLine,
        try(
            cmdObj perform(actionName, cmdLine, self player)
        ) catch(BadCommand,
            # Signalled when the more sophisticated parsing of a
            # command line fails and the command wishes to give others
            # a chance to run. TODO: make initial parsing better.
            continue
        ) pass
    )

)


RemotePlayerHandler := BaseCommandHandler clone do(
    with := method(aSocket, name,
        c := self clone
        player := Player makeNew(name) lexicalDo(
            setCommandHandler(c)
            setOut(SocketWriter withSocket(aSocket))
            moveTo(mainHall)
        )
        c setCommands(Commands clone)
        c setPlayer(player)
        c
    )
)


LocalPlayerHandler := BaseCommandHandler clone do(
    readCommand := method(ReadLine readLine("> "))
    start := method(
        loop(self singleStep)
    )
    singleStep := method(
        err := try(
            self doCommand(self readCommand)
        )
        err catch(Quit,
            "exit" println
            System exit)
        err catch(err println)
    )
)
