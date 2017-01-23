CURRENT_PATH = None

G = globals().copy()
L = locals().copy()


def execfile(path):
    global CURRENT_PATH

    with open(path) as f:
        try:
            CURRENT_PATH = path
            compiled = compile(f.read(), path, 'exec')
            exec(compiled, G, L)
        finally:
            CURRENT_PATH = None



execfile("a.py")
execfile("b.py")

def format_mod_namespace(ns):
    from pprint import pprint
    pprint(
        list(sorted(filter(lambda x: not x[0].startswith("_"), ns.items())))
    )

format_mod_namespace(L)
