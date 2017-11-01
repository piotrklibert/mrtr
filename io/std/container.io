Container := WorldObject inherit do(
    defattr(inventory, list())
    containerDesc ::= nil

    setShort("bezksztaltny iluzoryczny pojemnik")
    setLong("Pojemnik bez zadnych cech szczegolnych.")
    setContainerDesc("Pojemnik zawiera: ")

    defdesc(
        addSection("long")
        addSection("inventoryString")
    )

    inventoryString := method(
        if(inventory size > 0,
            containerDesc .. (inventory map(short) fmt),
            $"#{self short} nie zawiera niczego."
        )
    )

    notifyInvEnter = method(what, from,
        self inventory select(!= what) foreach(obj,
            try(
                obj notifyEnvEnter(what, from)
            )
        )
    )

    notifyInvLeave = method(what, to,
         self inventory foreach(obj,
            try(
                obj notifyEnvLeave(what, to)
            )
        )
    )

    notifyLoaded := method(prevObj,
        resend
        if(prevObj, prevObj inventory foreach(moveTo(self)))
    )


    add := method(obj,
        inventory append(obj)
        self notifyInvEnter(obj, obj comingFrom)
        self
    )
    rm := method(obj,
        inventory remove(obj)
        self notifyInvLeave(obj, obj goingTo)
        self
    )

    destroy := method(
        self inventory map(destroy)
        self setInventory(nil)
        resend
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
