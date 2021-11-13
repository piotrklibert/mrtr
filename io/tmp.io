Object doFile("tmp2.io")

# message([a, *b] <-(1, 3)) println
"###################################" println
doString("[b, a] <- list(1, 3)")
a println
# Sequence quoted := method(
#     q := 34 asCharacter
#     (q .. self .. q)
# )
# Message sep := method(Message clone setName(";"))

# Message joinMessages := method(
#     args := call evalArgs
#     arg0 := args at(0)

#     args slice(1) foreach(arg,
#         arg0 last setNext(Message sep)
#         arg0 last setNext(arg)
#     )

#     arg0
# )


# Object defattr := method(/*aName, initialValue, attrSlot*/
#     baseName := call argAt(0) name
#     setterName := "set" .. baseName asMutable capitalize
#     attrName := (call argAt(2) ?name) ifNilEval("_" .. baseName)
#     initVal := call evalArgAt(1)

#     getter := block(
#         attrName := call target getSlot(call message name) attrName
#         self perform(attrName)
#     )
#     getter attrName := attrName

#     setter := block(val,
#         attrName := call target getSlot(call message name) attrName
#         self setSlot(attrName, val)
#     ) setScope(nil)
#     setter attrName := attrName
#     call target lexicalDo(
#         setSlot(attrName, initVal)
#         setSlot(baseName, getter setIsActivatable(true))
#         setSlot(setterName, setter setIsActivatable(true))
#     )
# )

# x := Object clone do(
#     defattr(a, nil)
# )



# A := Object clone

# A a := method(writeln("a"); self)

# (A
#   a(1)
#   a(2))


# Namespace clone do (
#     lineLength := 40
#     s := "Four score and seven years ago, our forefathers brought forth upon this continent a new nation, dedicated to the proposition that all men were created equal."
#     words := s split
#     lengths := words map(size)

#     sum := 0
#     sums := list()
#     lengths foreach(x,
#         sums append(sum := sum + x + 1)
#     )

#     row_nums := sums map(x, (x / lineLength) floor)
#     rows := (0 to(row_nums last)) map(list())
#     for(i, 0, words size - 1,
#         r := row_nums at(i)
#         rows at(r) append(words at(i))
#     )

#     rows foreach(join(" ") println)

# )
# Messages := Object clone
# Messages do (
#     _connections := nil
#     connections := method(self _connections ifNilEval(setConnections(list)))
#     setConnections := method(v, self _connections := v)

#     _messages := nil
#     messages := method(self _messages ifNilEval(setMessages(Map clone)))
#     setMessages := method(v, self _messages := v)

#     add := method(k,v,
#         self connections foreach(conn,
#             if(conn != k, conn write(k uniqueId .. " says: " .. v))
#         )
#         self messages atPut(k uniqueId, v)
#     )

#     addConn := method(conn,
#         conns := self connections ifNilEval(
#             self connections := list()
#             connections
#         )
#         conns append(conn)
#     )
# )
