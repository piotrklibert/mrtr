List removeBySel := method(
    msg := call argAt(0)
    toBeRemoved := list()
    self foreach(x,
        if(x doMessage(msg) not,
            writeln("aaaaaa>>>", x doMessage(msg), msg)
            toBeRemoved append(x)
        )
    )
    toBeRemoved foreach(x,
        self remove(x)
    )
    self
)

Object assert := method(
    assertionerror := Exception clone
    arg := call argAt(0) clone doInContext(call sender)
    if(arg != true,
        assertionerror raise("Expected true, got #{arg} from '#{call argAt(0)}'" interpolate)
    )
)
Object ifTrueEval := method(if(self asBoolean, call evalArgAt(0)))
Object ifFalseEval := method(if(self not, call evalArgAt(0)))

Message sep := method(Message clone setName(";"))

Message joinMessages := method(
    args := call evalArgs
    arg0 := args at(0)

    args slice(1) foreach(arg,
        arg0 last setNext(Message sep)
        arg0 last setNext(arg)
    )

    arg0
)
Sequence stripCr := method(
    self asMutable removeSuffix("\r\n")
)

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


Sequence quoted := method(
    q := 34 asCharacter
    (q .. self .. q)
)

Object yourself := method(self)

Quit := Exception clone
BadCommand := Exception clone

File asString := method("<File: '" .. self name .. "'>")
Directory asString := method("<Dir: '" .. self name .. "'>")

Sequence beginsWithAnyOf := method(
    str := self
    call evalArgs map(prefix, str beginsWithSeq(prefix)) reduce(or)
)

Regex matches := method(str,
    self matchesIn(str) all size > 0
)

Sequence dedent := method(ignoreFirstLine,
    if(ignoreFirstLine isNil, ignoreFirstLine := true) # the default
    lines := self split("\n")
    if(ignoreFirstLine, lines := lines slice(1))
    indent := "^ +" asRegex matchesIn(lines at(0)) at(0) sizeInChars
    lines := lines map(exSlice(indent))
    lines join(" ")
)

Sequence wrap := method(lineLength,
    words := self split
    lines := list()
    curLine := "" asMutable
    curLen := 0
    words foreach(w,
        if(curLen + w size > lineLength,
            lines append(curLine asString)
            curLen := 0
            curLine zero
        )
        curLen := curLen + w size
        curLine appendSeq(" " .. w)
    )
    if(curLine size > 0,
        lines append(curLine))
    lines join("\n")
)


Sequence require := method(call sender doFile(self))
List fmt := method(
    if(self size == 1,
        return self first)
    if(self size == 0,
        return "")

    els := self slice(1)
    s := self at(0) asMutable
    els foreach(el,
        s appendSeq(", " .. el)
    )
    s

)

List firstOr := method(
    el := self first
    el ifNil(
        el := call evalArgAt(0)
    )
    el
)
