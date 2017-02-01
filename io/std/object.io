WorldObject := Object clone

WorldObject do(
    defattr(registry, Registry on(yourself))

    defattr(out, StdOut)
    descriptionFormatter ::= nil

    defattr(env, nil)
    defattr(comingFrom, nil)
    defattr(goingTo, nil)

    # set by the Namespace loader
    defattr(isClass, nil)
    defattr(loadName, nil)
    defattr(sourceFile, nil)

    name  ::= "<unnamed>"

    _long  := nil
    long := method(_long)
    setLong := method(val, self _long := val dedentIfNeeded)

    _short := nil
    short := method(_short)
    setShort := method(val, self _short := val)

    defdesc(
        addSection("short")
        addSection("long")
    )


    setShort("lewitujaca pulsujaca kula")
    setLong("
        Surowy obiekt: unoszaca sie w przestrzeni sfera... czegos. Ksztalty i
        kolory przedmiotu zmieniaja sie jak w kalejdoskopie, a kazda kombinacja
        jest jak nowy test Rorschacha. Oto surowa materia Chaosu, potezna
        energia czekajaca na uksztaltowanie.
    ")


    desc := method(descriptionFormatter forObject(self))

    asString := method(
        desc := if(self isClass,
            self sourceFile relPath,
            [
                self getSlot("name"),
                self getSlot("short"),
                self getSlot("uniqueId")
            ] select(asBoolean) first
        )
        $"<#{self type}: '#{desc}'>"
    )

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

    notifyLoaded := method(prevObj,
        debugWriteln($"Loading #{self sourceFile relPath}.")
        if(prevObj,
            self setEnv(prevObj env)
            self setRegistry(prevObj registry)
        )
    )

    notifyWillUnload := method()

    class := method(
        if(self isClass or (self == WorldObject),
            self,
            self proto class
        )
    )

    inherit := method(
        aClone := self clone
        WorldObject registry append(WeakLink clone setLink(aClone))
        aClone
    )

    makeNew := method(name,
        aClone := self clone
        name ifNil(
            name := self loadName asLowercase .. (self registry size + 1)
        )
        aClone name := name
        aClone setSourceFile(self class sourceFile)
        aClone setLoadName(self class loadName)
        aClone setIsClass(false)
        fromWhere := call sender Namespace currentlyLoadingFile ?relPath
        debugWriteln($"makeNew of #{self} called from: #{fromWhere}")
        self class registry append(WeakLink clone setLink(aClone))
        aClone
    )
)
wl := WeakLink clone
wl setLink(WorldObject)
WorldObject registry append(wl)
