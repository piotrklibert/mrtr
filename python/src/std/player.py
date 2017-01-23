def clone(what, cmdline):
    global REGISTRY
    if what in REGISTRY:
        [cls, _] = REGISTRY[what]
        if callable(getattr(cls, "auto_instantiate", None)):
            obj = cls.auto_instantiate()
        else:
            obj = cls()

        PLAYER._parent.add(obj)


def sp():
    obj = PLAYER._parent
    if obj:
        print(obj.desc)
    else:
        print("You're floating in an infinite void, there's nothing you could see here.")



def look(at_what):
    print(find(at_what).desc)



class Player(WorldObject):      # NOQA
    class defaults(WorldObject.defaults):  # NOQA
        def short(obj):
            return "a player"

    def get_command_matchers(self):
        return [
            self.match1,
            self.close,
            self.match_look,
            self.match_clone,
            self.match_sp,
            self.match_eval
        ]

    def match_eval(self, cmdline):
        if cmdline[0] == "!":
            def _f():
                print(eval(cmdline[1:].strip(), globals()))
            return _f

    def match_sp(self, cmdline):
        if cmdline.startswith("sp"):
            return lambda: sp()

    def match_look(self, cmdline):
        cmd = cmdline.split()
        if cmd[0] in ["look", "ob", "obejrzyj"]:
            return lambda: look(" ".join(cmd[1:]))

    def match1(self, cmdline):
        if cmdline.startswith("x"):
            return self.match1_handler

    def match1_handler(self):
        print("x"*20)

    def match_clone(self, cmdline):
        cmd = cmdline.split()
        if cmd[0] in ["clone"]:
            return lambda: clone(cmd[1], cmdline)

    def goto(self, what):
        global HERE
        obj = self._parent

        if obj:
            obj.rm(self)
        find(what).add(self)
        HERE = self._parent
        sp()

    def close(self, cmdline):
        cmd = cmdline.split()
        if cmd[0] in ["z", "zakoncz", "bye", "exit"]:
            def _f():
                raise KeyboardInterrupt()
            return _f
