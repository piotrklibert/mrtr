WorldObject := Object clone

WorldObject do(
    defattr(isClass, nil)
    defattr(registry, list())

    defattr(out, StdOut)
    defattr(description, Description clone)

    defattr(env, nil)
    defattr(comingFrom, nil)
    defattr(goingTo, nil)

    # set by the Namespace loader
    defattr(name, nil)
    defattr(file, nil)


    defdesc := method(aChunkOrder, chunks)



    baseDesc := Description compose(
        addSection("baseDesc", "
            Surowy obiekt: unoszaca sie w przestrzeni sfera czegos, co wymyka
            sie wszelkiemu opisowi. Ksztalty i kolory przedmiotu zmieniaja sie
            jak w kalejdoskopie, a kazda kombinacja jest jak maly test
            Rorschacha. Masz wrazenie, ze lepiej nie wpatrywac sie wen zbyt
            dlugo.
        " dedent)
    )

    id := method(asString)
    desc := method(
        baseDesc
    )
    asString := method("<#{self type}: #{self name}>" interpolate)

    destroy := method(
        self env ?rm(self)
        self setEnv(nil)
        if(self registry size > 0, self registry foreach(link ?destroy))
    )

    # callbacks called when an object appears/disappears in current
    # environment
    notifyGone    := method(what, self)
    notifyArrived := method(what, self)


    class := method(
        if(self isClass or (self == WorldObject),
            self,
            self proto class
        )
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
        self class registry append(WeakLink clone setLink(aClone))
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
        inEnv := self env inventory select(name == what)
        inInv := self inventory select(name == what)
        inEnv clone appendSeq(inInv)
    )
)
wl := WeakLink clone
wl setLink(WorldObject)
WorldObject registry append(wl)
