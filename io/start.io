Socket
Server
Regex
Range
SHA1
Random


Lobby do(
    # Object debugOn()
    # Scheduler currentCoroutine setMessageDebugging(true)
    debugModeEnabled := true
)

Lobby do(
    doFile("utils/syntax.io")
    doFile("utils/str.io")
    doFile("utils/misc.io")
    doFile("utils/attrs.io")
    doFile("utils/reg.io")
    doFile("utils/details.io")
    doFile("utils/exits.io")
    doFile("utils/events.io")
    doFile("utils/err.io")
)

Lobby doFile("namespace.io")


Namespace do(
    loadFile("core/paths.io")
    loadFile("core/output_handler.io")
    loadFile("core/colors.io")
    loadFile("core/inspect.io")
    loadFile("core/command_set.io")
    loadFile("core/commands.io")
    loadFile("core/socket_server.io")
    loadFile("core/heartbeat.io")
    loadFile("core/command_handler.io")
)


Namespace do(
    loadStd("description.io")
    loadStd("object.io")
    loadStd("container.io")
    loadStd("room.io")
    loadStd("player.io")
)

Namespace loadWorldObj("main_hall.io")

doFile("tests/tests.io")

heartbeat @start
MTRServer start



#
# LocalPlayerHandler clone start
# Collector allObjects foreach(i, obj,
#     i println
#     if(i == 566, continue)
#     getSlot("obj") isActivatable print
#     getSlot("obj") uniqueId println
#     nil
# )
# writeln("END")


# l1 := Literal with("a")
# l2 := Literal with("b")

# And with([l1, l2]) parseString("ab")
# And with([l1, l2]) println

# MatchFirst with([]) println

# DSL := Object clone do(
#     do := method(
#         msg := call argAt(0)
#         cln := self clone
#         cln self := cln
#         cln appendProto(call sender)
#         cln doMessage(msg)
#     )
#     L := method(x, Literal with(x))
# )

# p := DSL do(
#     L("sdsd") | "as"
# )

# p parseString("as") println
# p parseString("sdsd")
