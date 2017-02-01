Socket
Server
Regex
Range
SHA1
Random
Namespace

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

# LocalPlayerHandler clone start
heartbeat @start
MTRServer start
#
# Collector allObjects foreach(i, obj,
#     i println
#     if(i == 566, continue)
#     getSlot("obj") isActivatable print
#     getSlot("obj") uniqueId println
#     nil
# )
# writeln("END")
