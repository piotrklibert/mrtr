Registry := List clone do(
    on := method(obj,
        WO := Lobby getSlot("WorldObject")
        cls := if(WO not or (obj == WO), WorldRegistry, Registry)
        cln := cls clone
        (cls == WorldRegistry) ifTrue(cls globalRegistryInstance := cln)
        cln
    )

    cleanUp := method(
        self removeSeq(self select(link not))
        self
    )

    matchObject := method(objDesc, obj,
        (obj ?loadName == objDesc) or \
        (obj ?sourceFile relPath endsWithSeq(objDesc)) or \
        (obj ?name == objDesc)
    )

    find := method(desc, self map(link) select(obj, matchObject(desc, obj)))
    findAny := method(name, self find(name) first)
    # asString := method("<Registry: [" .. self clone map(link asString) fmt .. "]>")
)

WorldRegistry := Registry clone do(
    getRegistry := method(
        if(self hasLocalSlot("globalRegistryInstance"),
            globalRegistryInstance,
            self
        )
    )
    cleanUp := method(
        resend
        self map(link registry) select(!= self) foreach(cleanUp)
        self
    )
    getAllInstances := method(
        self getRegistry map(link registry) flatten map(link)
    )
    findInstances := method(desc,
        self getRegistry getAllInstances select(obj, matchObject(desc, obj))
    )
    findInstance := method(desc,
        self getRegistry findInstances(desc) first
    )
)
