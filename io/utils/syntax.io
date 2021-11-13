OperatorTable addOperator("$", 13)
OperatorTable addOperator(":", 13)
OperatorTable addOperator("to", 13)
OperatorTable addOperator("apropos", 13)
OperatorTable addOperator("->", 13)

Object -> := method(b, list(self, b))


Object $ := method(
    int := "interpolate" asMessage
    call evalArgs map(str,
        ctx := call sender clone
        ctx appendProto(thisContext)
        __msg := message(ident(str interpolate)) clone
        call sender doMessage(__msg, ctx)
    ) join
)

Object $$ := Object getSlot("$")


Object squareBrackets := method(Object performWithArgList("list", call evalArgs))
List asString := method("[" .. self fmt .. "]")
List setSlot("squareBrackets", List getSlot("at"))

Object assert := method(
    assertionerror := Exception clone
    arg := call argAt(0) clone doInContext(call sender)
    if(arg != true,
        assertionerror raise("Expected true, got #{arg} from '#{call argAt(0)}'" interpolate)
    )
)

nil catch := method(self)
nil finally := method(call sender doMessage(call argAt(0)))
Exception finally := method(call sender doMessage(call argAt(0)))

nil whenNil := Object getSlot("evalArg")
Object whenNil := method(self)

nil whenNotNil := method(nil)
Object whenNotNil := method(
    obj := Object clone lexicalDo(.it := self)
    ctx := call sender thisContext
    ctx appendProto(obj)
    res := call relayStopStatus(ctx doMessage(call argAt(0), ctx))
    ctx removeProto(obj)
    res
)

# TODO: make exception handling closer to Smalltalk?
Object try2 := method(
    coro := Coroutine clone
    coro setParentCoroutine(Scheduler currentCoroutine)
    coro setRunTarget(call sender)
    coro setRunLocals(call sender)
    coro setRunMessage(call argAt(0))
    coro run
    if(coro exception, coro exception, coro result)
)

Object whenTrue := method(
    if(self asBoolean,
        ctx := call sender
        ctx .it := self
        res := call relayStopStatus(ctx doMessage(call argAt(0), ctx))
        ctx removeSlot(".it")
        res
    ,
        self
    )
)
Object whenFalse := method(
    if(self asBoolean not,
        ctx := call sender
        call relayStopStatus(ctx doMessage(call argAt(0), ctx))
    ,
        self
    )
)

Object ident := method(x, x)
Object yourself := method(self)

List sortByIt := method(
    msg := call argAt(0)
    b := block(x, x doMessage(msg))
    self sortBy(b)
)

List firstOr := method(
    self first ifNilEval(call evalArgAt(0))
)


Object destructure := method(
  # target [a, b] <- list(9,8) becomes: target a := 9; target b := 8
  msg := call argAt(0)
  lst := call evalArgAt(1)
  target := call target
  msg arguments foreach(i, x,
      target setSlot(x name, lst at(i))
  )
  target
)
# inform the parser about our new operator
OperatorTable addAssignOperator("<-", "destructure")


Map asString := method(
    if(self size == 0, return "{}")
    s := "{\n" asMutable
    self foreach(k, v, s appendSeq("    " .. k .. " := ", v, "\n"))
    (s .. "}") asString
)


Number .. := method(other,
    [self, other]
)

Sequence asChar := method(self at(0))


Object curlyBrackets := method(
    dict := Map clone
    msg := call message arguments first ifNil(return dict)
    dict setSlot := dict getSlot("atPut")
    dict doMessage(msg)
    dict removeSlot("setSlot")
    dict
)

Sequence %% := method(
    args := call evalArgs
    res := ""
    i := 0
    "%s" asRegex matchesIn(self) splitString foreach(chunk,
        writeln(chunk, args[i])
        res := res .. chunk .. args at(i) whenNil("")
        i := i + 1
    )
    res
)
Sequence % := Sequence getSlot("%%")

Object isInstance := method(
    arg := call evalArgAt(0)
    types := if(arg isKindOf(List), arg, call evalArgs)
    types foreach(t, self isKindOf(t) ifTrue(return true))
    false
)

List asRange := method(self at(0) to(self at(1)))
Map contains := method(k, self at(k) isNil not)
