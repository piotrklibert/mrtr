CommandSet := Object clone do(
    defattr(cmdList, list())

    defcommand := method(name, predMsg, action,
        self cmdList append(list(predMsg, name))
        self setSlot(name, action setIsActivatable(true))
    )

    getCmdList := method(
        self ancestors select(hasLocalSlot("_cmdList")) map(cmdList) reduce(union)
    )

    defcmd := method(
        cls := call sender
        name := call argAt(0) name
        predMsg := call argAt(1)
        actionMsg := call argAt(2)

        meth := block(cmd, actor,
            ctx := call target
            ctx actor := actor
            ctx line := cmd
            ctx call := call
            ctx self := call target
            ctx doMessage(actionMsg)
        )

        defcommand(name, predMsg, meth)
    )

    getCmdHandler := method(cmdline,
        action := nil
        self getCmdList foreach(val,
            pred := val at(0)
            res := cmdline doMessage(pred)
            if(res,
                # "Handler found: '#{val at(1)}' for command '#{cmdline}' in #{self getSlot(\"name\") ifNilEval(self type)}" interpolate println
                action := val at(1)
                break
            )
        )
        action
    )
)
