Registry := List clone do(
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

    findRoom := method(path,
        Room registry detect(link ?file path == path)
    )
)

WorldObject := Object clone

WorldObject do(
    defattr(isClass, nil)
    defattr(registry, list())

    defattr(out, StdOut)
    descriptionFormatter ::= nil

    defattr(env, nil)
    defattr(comingFrom, nil)
    defattr(goingTo, nil)

    # set by the Namespace loader
    defattr(name, nil)
    defattr(file, nil)

    short ::= nil
    long  ::= nil
    setLong := method(val, self long := val dedentIfNeeded)

    defdesc(
        addSection("short")
        addSection("long")
    )


    setShort("lewitujaca pulsujaca kula")
    setLong("
        Surowy obiekt: unoszaca sie w przestrzeni sfera... czegos. Ksztalty i
        kolory przedmiotu zmieniaja sie jak w kalejdoskopie, a kazda kombinacja
        jest jak maly test Rorschacha. To surowa materia Chaosu, potezna energia
        czekajaca na uksztaltowanie.
    ")


    desc := method(descriptionFormatter forObject(self))

    asString := method($"<#{self type}: #{self name}>")

    destroy := method(
        self env ?rm(self)
        self setEnv(nil)
        if(self registry size > 0,
            self registry foreach(link ?destroy))
        self become(nil)
    )

    # callbacks called when an object appears/disappears in current
    # environment
    notifyEnvEnter := method(what, self)
    notifyEnvLeave := method(what, self)

    notifyInvEnter := method(what, self)
    notifyInvLeave := method(what, self)

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
)
wl := WeakLink clone
wl setLink(WorldObject)
WorldObject registry append(wl)
