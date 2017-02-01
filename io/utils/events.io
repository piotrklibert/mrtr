EventList := List clone do(

)

EventRunner := Object clone do(
    debugOn()
    count := 0
    delay := 120
    msg := message(playEvent)

    targetObject ::= nil
    with := method(anObject,
        debugWriteln($"EventRunner: creating instance for #{anObject}")
        cln := EventRunner clone
        cln setTargetObject(WeakLink clone setLink(anObject))
        cln @start()
        cln
    )

    start := method(
        try(loop(step; yield))
        debugWriteln("EventRunner finished running!")
    )

    step := method(
        if(self targetObject link not,
            Exception raise("EventRunner: targetObject is gone.")
        )
        self count := self count + 1
        if(count > delay,
            self count := 0
            self sendMessage()
        )
        wait(1)
    )

    sendMessage := method(
        self msg doInContext(self targetObject link)
    )
)
