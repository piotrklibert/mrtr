Object getWordData := method(word,
    c := SystemCall with("python odmiana.py")
    c arguments append(word)
    doString(c run)
)

Object copySlots := method(other,
    self slotNames foreach(slot,
        other setSlot(slot, self getSlot(slot))
    )
)

Object copyWithAttrs := method(
    c := self clone
    self slotNames foreach(s,
        c setSlot(s, self getSlot(s))
    )
    c
)


File asFile := method(self)

File relPath := method(
    self path asMutable removePrefix(System launchPath) strip("/")
)
File worldRelPath := method(
    self path asMutable \
        removePrefix(System launchPath) \
        strip("/") removePrefix("world/")
)


List removeBySel := method(
    msg := call argAt(0)
    self clone removeSeq(self select(x, x doMessage(msg)))
)



Message joinMessages := method(
    args := call evalArgs
    arg0 := args at(0)

    args slice(1) foreach(arg,
        arg0 last setNext(Message sep)
        arg0 last setNext(arg)
    )

    arg0
)
Message sep := method(Message clone setName(";"))
