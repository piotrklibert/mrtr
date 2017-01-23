Container := WorldObject inherit do(
    init := method(
        resend
        self inventory := list()
    )
    inventory := nil
    containerDesc := "Pojemnik zawiera: "

    desc := method(
        resend .. "\n" .. containerContents
    )
    containerContents := method(
        containerDesc .. (inventory map(name) fmt)
    )

    add := method(obj,
        inventory foreach(notifyArrived(obj))
        inventory append(obj)
        self
    )
    rm := method(obj,
        inventory remove(obj)
        inventory foreach(notifyGone(obj))
        self
    )
)

WorldObject moveTo := method(target,
    self environ ifNonNil(
        self setComingFrom(self environ)
        self setGoingTo(target)
        self environ rm(self)
    )

    target add(self)
    self setEnviron(target)

    self setComingFrom(nil)
    self setGoingTo(nil)
    self
)
