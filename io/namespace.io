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

    setNamespaceData := method(name, object,
        object ?setSourceFile(currentlyLoadingFile)
        object ?setLoadName(name)
        object ?setIsClass(name at(0) isUppercase)
    )


    loadNew := method(attrName,
        debugWriteln("+#{attrName}" interpolate)
        newVal := self getSlot(attrName)
        setNamespaceData(attrName, newVal)
        newVal ?notifyLoaded(nil)
        Lobby setSlot(attrName, newVal)
    )

    loadUpdate := method(attrName,
        debugWriteln("*#{attrName}" interpolate)
        setNamespaceData(attrName, self getSlot(attrName))

        oldVal := Lobby getSlot(attrName)
        newVal := self getSlot(attrName)

        oldVal ?notifyWillUnload()
        newVal ?notifyLoaded(oldVal)

        oldVal become(newVal)
        WorldObject registry cleanUp
    )

    doLoad := method(
        diff := self getDiff
        diff new     foreach(attrName, loadNew(attrName))
        diff updated foreach(attrName, loadUpdate(attrName))

        Lobby getSlot(diff new first ifNilEval(diff updated first))
        self removeAllSlots()
    )
)
