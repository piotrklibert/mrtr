BaseCommandHandler := Object clone do(
    defattr(lastCommand, nil)
    defattr(commands, nil, globalCommands)
    defattr(player, nil, playerObject)

    makeNew := method(
        cmdHandler := self clone
        cmdHandler doMessage(call argAt(0), call sender)
        cmdHandler
    )

    asString := method("[commands=#{commands};player=#{player}]" interpolate)

    commandSets := method(
        p := self player
        list(
            p, p inventory, p environ, p environ inventory, self commands
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
            self player out writeln("Huh?")
        )
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
        player := Player makeNew(name) lexicalDo(
            setSocket(aSocket)
            moveTo(mainHall)
        )
        c := self clone
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