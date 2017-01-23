HERE         = None             # NOQA
P1 = PLAYER  = None             # NOQA
REGISTRY     = {}               # NOQA
CURRENT_PATH = None             # NOQA
AUTO_INIT    = []               # NOQA

COMMANDS = type("mutableobject", (), {})()
COMMANDS.get_command_matchers = lambda: []
