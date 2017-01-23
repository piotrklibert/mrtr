Namespace := Object clone
Namespace do(
    currentlyLoadingFile := nil

    loadWorldObj := method(file,
        file := Paths worldDir fileNamed(file) path
        loadFile(file)
    )
    loadStd := method(file,
        file := Paths stdDir fileNamed(file) path
        loadFile(file)
    )
    loadFile := method(file,
        "Reading file #{file}: " interpolate print
        ns := if(self == Namespace, Namespace clone, self)
        self file := file
        Namespace currentlyLoadingFile := file
        ns doFile(file)
        loadedObj := ns doLoad()
        Namespace currentlyLoadingFile := nil
        loadedObj
    )

    getDiff := method(
        lobbyNames := Lobby slotNames
        newNames := self slotNames select(in(lobbyNames) not)
        updatedNames := self slotNames select(in(lobbyNames))
        Map with(
            "new", newNames remove("FILE"),
            "updated", updatedNames remove("FILE"),
            "isEmpty", (newNames size + updatedNames size > 0) not
        ) asObject
    )

    doLoad := method(
        diff := self getDiff
        diff new foreach(attrName,
            "+#{attrName} " interpolate print
            self getSlot(attrName) ?setFile(File with(file))
            self getSlot(attrName) ?setName(attrName)
            Lobby setSlot(attrName, self getSlot(attrName))
        )
        diff updated foreach(attrName,
            "*#{attrName} " interpolate print
            self getSlot(attrName) ?setFile(File with(file))
            self getSlot(attrName) ?setName(attrName)

            # TODO: what to copy from the old version to new?
            if(Lobby getSlot(attrName) isKindOf(WorldObject),
                oldVal := Lobby getSlot(attrName)
                newVal := self getSlot(attrName)
                newVal setEnviron(oldVal environ)
                newVal setRegistry(oldVal registry)
                if(oldVal isKindOf(Container),
                    oldVal inventory foreach(
                        moveTo(newVal)
                    )
                )
            )
            Lobby getSlot(attrName) become(self getSlot(attrName))
        )
        if(diff isEmpty not, writeln)
        Lobby getSlot(diff new firstOr(diff updated first))
    )
)
