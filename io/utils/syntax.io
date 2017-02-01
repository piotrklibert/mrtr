OperatorTable addOperator("$", 13)
Object $ := method(
    int := "interpolate" asMessage
    call evalArgs map(str,
        ctx := call sender clone
        ctx appendProto(thisContext)
        msg := message(ident(str interpolate)) clone
        call sender doMessage(msg, ctx)
    ) join
)

Object $$ := Object getSlot("$")


Object squareBrackets := method(Object performWithArgList("list", call evalArgs))
List asString := method("[" .. self fmt .. "]")


Object assert := method(
    assertionerror := Exception clone
    arg := call argAt(0) clone doInContext(call sender)
    if(arg != true,
        assertionerror raise("Expected true, got #{arg} from '#{call argAt(0)}'" interpolate)
    )
)

Object ifTrueEval := method(if(self asBoolean, call evalArgAt(0)))
Object ifFalseEval := method(if(self not, call evalArgAt(0)))
Object ident := method(x, x)
Object yourself := method(self)

List firstOr := method(
    self first ifNilEval(call evalArgAt(0))
)
