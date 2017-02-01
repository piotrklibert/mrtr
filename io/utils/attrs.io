Object defattr := method(/*aName, initialValue, attrSlot*/
    baseName := call argAt(0) name
    setterName := "set" .. baseName asMutable capitalize
    attrName := (call argAt(2) ?name) ifNilEval("_" .. baseName)
    initMsg := call argAt(1)

    getter := block(
        g := call target getSlot(call message name)
        attrName := getSlot("g") attrName
        initMsg := getSlot("g") initMsg
        if(self hasLocalSlot(attrName) not,
            self setSlot(attrName, nil)
        )
        self getSlot(attrName) ifNilEval(
            init := initMsg doInContext(call target)
            self setSlot(attrName, init)
            init
        )
    ) setScope(nil)
    getter attrName := attrName
    getter initMsg := initMsg

    setter := block(val,
        attrName := call target getSlot(call message name) attrName
        # writeln("Setting ", attrName, " ", val)
        self setSlot(attrName, val)
        self
    ) setScope(nil)
    setter attrName := attrName
    setter initMsg := initMsg

    call target lexicalDo(
        setSlot(attrName, nil)
        setSlot(baseName, getter setIsActivatable(true))
        setSlot(setterName, setter setIsActivatable(true))
    )
)
