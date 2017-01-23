from collections import defaultdict

from core._globals import AUTO_INIT, CURRENT_PATH, REGISTRY


class WorldObjectClass(type):
    objects = defaultdict(dict)

    def __new__(_type, name, bases, ctx, **kwargs):
        ctx["_objects"] = WorldObjectClass.objects

        for attr in ["name", "short", "desc"]:
            val = ctx.get(attr)
            if not val:
                continue
            if isinstance(val, str):
                ctx["_"+attr] = val
                del ctx[attr]

        cls = super().__new__(_type, name, bases, ctx, **kwargs)

        auto = getattr(cls, "auto_instantiate", None)
        if auto:
            if callable(auto):
                AUTO_INIT.append(auto)
            else:
                AUTO_INIT.append(cls)

        if CURRENT_PATH:
            REGISTRY[name] = [cls, CURRENT_PATH]
        else:
            REGISTRY[name] = [cls, __file__]

        return cls
