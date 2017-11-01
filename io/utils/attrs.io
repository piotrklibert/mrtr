Object defattr := method(/*aName, initializationMsg, setterKey */
    # Assume aName == "attrib", then:
    #
    #    baseName   == "attrib"
    #    setterName == "setAttrib"
    #    attrName   == "_attrib"
    #
    # See tests for more.

    cls := call target

    baseName   := call argAt(0) name
    setterName := "set" .. baseName asMutable capitalize
    attrName   :="_" .. baseName
    initMsg    := call argAt(1)
    setterKey  := call argAt(2)
    if(setterKey ?name == "block",
        # eval message to get the Block object to be called with a new value
        setterKey := call evalArgAt(2)
    )

    getter := block(
        currentMethod := self getSlot(call message name) clone setIsActivatable(false)
        attrName := currentMethod attrName
        if(self hasLocalSlot(attrName) not,
            initVal := currentMethod initMsg doInContext(call target)
            self setSlot(attrName, initVal)
        )
        self getSlot(attrName)
    ) setScope(nil)
    getter attrName := attrName
    getter initMsg := initMsg

    setter := block(val,
        attrName := call target getSlot(call message name) attrName
        setterKey := call target getSlot(call message name) setterKey
        if(setterKey isNil not,
            val := if(setterKey isKindOf(Block),
                setterKey call(val)
            ,
                setterKey doInContext(val)
            )
        )
        self setSlot(attrName, val)
        self
    ) setScope(nil)
    setter attrName := attrName
    setter setterKey := setterKey

    cls lexicalDo(
        setSlot(baseName, getter setIsActivatable(true))
        setSlot(setterName, setter setIsActivatable(true))
    )
)
