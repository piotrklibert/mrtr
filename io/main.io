Socket
Server
Regex
Range
Namespace

Namespace do(
    loadFile("core/utils.io")
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
