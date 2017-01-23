class Container(WorldObject):   # NOQA
    class defaults(WorldObject.defaults):  # NOQA
        short = "a simple container"
        base_desc = """
        A very simple container. Has an inventory which can hold other things.
        """
        container_desc = "It contains: "

    def __init__(self, **kwargs):
        self.inventory = []
        super().__init__(**kwargs)

        if not hasattr(self, "container_desc"):
            self.container_desc = kwargs.get("container_desc",
                                             self.defaults.container_desc)
        if not hasattr(self, "base_desc"):
            self.base_desc = kwargs.get("base_desc", self.defaults.base_desc)

    def add(self, obj):
        obj._parent = self
        self.inventory.append(obj)
        return self

    def rm(self, pos):
        if isinstance(pos, int):
            obj = self.inventory[pos]
            obj._parent = None
            del self.inventory[pos]
        else:                   # we assume it's an object instance if not int
            obj = pos
            obj._parent = None
            self.inventory.remove(obj)

        return self

    @property
    def desc(self):
        if self.inventory:
            addendum = "\n" + self.container_desc \
                       + ", ".join(map(lambda x: x.short, self.inventory))
        else:
            addendum = ""

        return self.base_desc + addendum
