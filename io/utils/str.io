Block oldAsString := Block getSlot("asString")
Block asFullString := Block getSlot("asString")
Block asString := Block getSlot("asSimpleString")
File asString := method("<File: '" .. self name .. "'>")
Directory asString := method("<Dir: '" .. self name .. "'>")


Sequence require := method(call sender doFile(self))

PRE := Sequence clone do(
    with := method(aString,
        cln := self clone
        cln copy(aString)
        cln
    )

    dedent := method(
        self
    )
)

PRE : := PRE getSlot("with")


Sequence beginsWithAnyOf := method(
    str := self
    if(call message arguments size == 1,
        args := call evalArgAt(0),
        args := call evalArgs
    )
    args map(prefix, str beginsWithSeq(prefix)) reduce(or)
)


// TODO: deprecated
Sequence dedentIfNeeded := method(
    debugWriteln("Deprecated method dedentIfNeeded called.")
    self dedent
)
Sequence dedent := method(
    lines := self split("\n")
    if(lines size == 0, return "")
    if(lines size == 1, return self)

    firstLine := lines first
    lines := lines slice(1)
    indent := "^ +" asRegex matchesIn(lines at(0)) at(0) sizeInChars
    lines := lines map(exSlice(indent))
    if(firstLine size > 0,
        lines prepend(firstLine stripped)
    )
    lines1 := []
    for(i, 0, lines size - 1,
        if(lines at(i) ?size == 0,
            lines1 append("\n")
        ,
            lines1 append(lines at(i))
        )

    )

    lines1 join(" ") stripped asMutable replaceSeq("\n ", "\n") asString
)

Sequence wrap := method(lineLength,
    lineLength ifNil(return self)
    out := []
    self split("\n") foreach(line,
        words := line split
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
            lines append(curLine stripped))
        out append(lines join("\n"))
    )
    out join("\n")
)

Sequence stripped := method(
    self asMutable performWithArgList("strip", call evalArgs)
)

Sequence stripCr := method(
    self asMutable removeSuffix("\r\n")
)

Sequence quoted := method(
    q := 34 asCharacter
    (q .. self .. q)
)


Regex matches := method(str,
    self matchesIn(str) all size > 0
)


List fmt := method(
    if(self size == 1,
        return self first)
    if(self size == 0,
        return "")

    els := self slice(1)
    s := self at(0) asString asMutable
    els foreach(el,
        s appendSeq(", " .. el)
    )
    s asString
)
