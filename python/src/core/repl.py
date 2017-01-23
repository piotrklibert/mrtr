import sys

from glob import glob

from core.meta import WorldObjectClass                # NOQA
from core._globals import AUTO_INIT, COMMANDS, PLAYER, CURRENT_PATH, REGISTRY  # NOQA
from core.find import find                                           # NOQA

import logging
logging.basicConfig(level=logging.DEBUG)


def load_std():
    std_path = "./std/"         # TODO: config var
    # import ast
    # list(filter(
    # lambda x: isinstance(x, ast.ClassDef),
    # ast.iter_child_nodes(ast.parse(open("std/player.py").read()))))[0].bases[0].id

    execfile("{}/object.py".format(std_path))
    for fname in glob("{}/*.py".format(std_path)):
        if "object.py" in fname:
            continue
        # print(fname)
        execfile(fname)


def do_init():
    for f in AUTO_INIT:
        f()


def execfile(path):
    global CURRENT_PATH

    with open(path) as f:
        try:
            CURRENT_PATH = path
            compiled = compile(f.read(), path, 'exec')
            exec(compiled, globals(), globals())
        finally:
            CURRENT_PATH = None


def start_repl():
    global PLAYER

    print("Loading world...")
    load_std()
    do_init()

    PLAYER = Player(            # NOQA
        name="player1",
        short="player1",
        desc="Player has no description."
    )
    PLAYER.goto("room")
    while True:
        # TODO: readline
        # TODO: networking
        try:
            cmd = input("> ")
            PLAYER.do_cmd(cmd)
        except (KeyboardInterrupt, EOFError):
            print("Exiting...")
            sys.exit(0)
        except Exception:
            import traceback
            traceback.print_exc()
