Container := WorldObject inherit do(
    defattr(inventory, list())
    containerDesc := "Pojemnik zawiera: "
    baseDesc := "Pojemnik bez zadnych cech szczegolnych."

    destroy := method(
        resend
        self inventory map(destroy)
    )

    desc := method(
        d := super("description")
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
    self setGoingTo(target)
    self env ifNonNil(
        self setComingFrom(self env)
        self env rm(self)
    )

    target add(self)
    self setEnv(target)

    self setComingFrom(nil)
    self setGoingTo(nil)
    self
)
