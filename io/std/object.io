WorldObject := Object clone

WorldObject do(
    defattr(environ, nil)
    defattr(out, StdOut)
    defattr(comingFrom, nil)
    defattr(goingTo, nil)

    # set by the Namespace loader
    defattr(name, nil)
    defattr(file, nil)
    baseDesc := "A basic object without any features."

    id := method(asString)
    desc := method(
        baseDesc
    )
    asString := method("<#{self type}: #{self name}>" interpolate)

    registry := method(self initRegistry; self _registry)
    setRegistry := method(val, self _registry := val)
    initRegistry := method(
        if(self hasLocalSlot("_registry") not,
            self _registry := list())
    )

    notifyGone := method(what,
        /* do nothing by default */
        self
    )

    notifyArrived := method(what,
        /* do nothing by default */
        self
    )


    inherit := method(
        aClone := self clone
        WorldObject registry append(
            WeakLink clone setLink(aClone)
        )
        aClone
    )

    makeNew := method(name,
        aClone := self clone
        name ifNil(
            name := self name asLowercase .. (self registry size + 1) asString
        )
        aClone name := name
        self registry append(WeakLink clone setLink(aClone))
        aClone
    )

    registryFindAll := method(name,
        res := list()
        self registry map(link) foreach(cls,
            cls registry map(link) foreach(obj,
                if(obj name == name, res append(obj))
            )
        )
        res
    )

    registryFind := method(name,
        self registryFindAll(name) first
    )

    find := method(what,
        found := false
        inEnv := self environ inventory select(name == what)
        inInv := self inventory select(name == what)
        inEnv clone appendSeq(inInv)
    )
)
wl := WeakLink clone
wl setLink(WorldObject)
WorldObject registry append(wl)
