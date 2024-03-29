Socket consumeBuffer := method(
    msg := self readBuffer asString
    self readBuffer empty
    msg
)


BaseConnectionHandler := Object clone do(
    defattr(socket, nil)
    defattr(playerHandler, nil)

    handleConnect := method()
    handleLine    := method()
    handleClose   := method($$("[Closed #{self socket host}]") println)
    handleNetworkError   := method(err,
        if(err message == "Timeout",
            "continue" asMessage
        ,
            err coroutine backTraceString println; "break" asMessage
        )
    )

    checkMsg := method(msg,
        (msg at(0) == 4) ifTrue(Quit raise("EOF"))
    )

    doLine := method(msg,
            ex := try(
                self checkMsg(msg)
                self handleLine(msg stripCr)
            )
            ex catch(Quit,
                self socket write("Exiting...\n")
                self socket close
                break
            ) catch(
                self socket writeln("Got exception:")
                self socket writeln(ex showStack)
                self socket writeln(ex coroutine backTraceString)
            )
    )

    handlerLoop := method(
        while(self socket isOpen,
            msg := self socket read
            if(msg isKindOf(Error),
                canContinue := self handleNetworkError(msg)
                thisContext doMessage(canContinue)
            )
            msg := self socket consumeBuffer
            self doLine(msg)
        )
    )

    with := method(aSocket, self clone setSocket(aSocket))

    start := method(
        self handleConnect(self socket)
        self handlerLoop()
        self handleClose()
    )
)


ConnectionHandler := BaseConnectionHandler clone do(
    /*
     * All object construction and initialization happens here.
     */
    handleConnect := method(
        name := if(Lobby debugModeEnabled not,
            self socket write("Your name? ")
            self socket readUntilSeq("\r\n")
        ,
            Object clone uniqueId asString
        )
        self setPlayerHandler(RemotePlayerHandler with(self socket, name))
        self playerHandler doCommand("sp")
        Lobby Player _players append([Coroutine currentCoroutine,
                                      self playerHandler player])
    )

    handleLine := method(aLine,
        # For an out-of-order execution, create a copy of a handler for every
        # request and then send an async message to it:
        #   self playerHandler copyWithAttrs @doCommand(aLine)
        # But then it's hard to know what results come from which command.
        self playerHandler doCommand(aLine)
    )

    handleClose := method(
        Lobby Player _players selectInPlace(last != self playerHandler player)
        self playerHandler destroy
        resend
    )
)


MTRServer := Server clone do(
    setPort(8500)
    start := method(write("[Starting MTRServer on port 8500]\n"); resend)

    handleSocket := method(aSocket,
        ConnectionHandler with(aSocket) @start
    )
)
