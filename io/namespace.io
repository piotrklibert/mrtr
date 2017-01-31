WrappedFile := Object clone do(
    currentChecksum := method(self file sha1String)

    with := method(aFile, aSlotList,
        wfile := WrappedFile clone
        wfile file := aFile
        wfile checksum := aFile sha1String
        wfile slots := aSlotList
        wfile
    )
)

Namespace := Object clone
Namespace do(
    loadedFiles ::= list()
    currentlyLoadingFile ::= nil

    ensureLoaded := method(file,
        self loadedFiles map(file relPath) detect(== file) ifNil(
            self loadFile(file)
        )
    )

    loadStd := method(file, loadFile(Paths stdDir fileNamed(file)))
    loadWorldObj := method(file, loadFile(Paths worldDir fileNamed(file)))

    loadFile := method(aFile,
        loadedObj := nil
        file := aFile asFile
        ns := if(self == Namespace, Namespace clone, self)

        Namespace setCurrentlyLoadingFile(file)
        ex := try(
            ns doFile(file path)
            loadedObj := ns doLoad()
        )
        ex catch(
            writeln("Error evaluating #{file path}: #{ex}" interpolate)
        )
        ex ifNil(
            loadedFiles append(WrappedFile with(file))
        )
        Namespace setCurrentlyLoadingFile(nil)
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
            # "+#{attrName} " interpolate println
            self getSlot(attrName) ?setClassFile(currentlyLoadingFile)
            self getSlot(attrName) ?setClassName(attrName)
            self getSlot(attrName) ?setIsClass(attrName at(0) isUppercase)
            Lobby setSlot(attrName, self getSlot(attrName))
        )
        diff updated foreach(attrName,
            # "*#{attrName} " interpolate println
            self getSlot(attrName) ?setClassFile(currentlyLoadingFile)
            self getSlot(attrName) ?setClassName(attrName)

            # TODO: what to copy from the old version to new?
            if(Lobby getSlot(attrName) isKindOf(WorldObject),
                oldVal := Lobby getSlot(attrName)
                newVal := self getSlot(attrName)
                newVal setEnv(oldVal env)
                newVal setRegistry(oldVal registry)
                if(oldVal isKindOf(Container),
                    oldVal inventory foreach(
                        moveTo(newVal)
                    )
                )
            )
            Lobby getSlot(attrName) become(self getSlot(attrName))
        )
        if(diff updated size > 0, writeln)
        Lobby getSlot(diff new firstOr(diff updated first))
    )
)
