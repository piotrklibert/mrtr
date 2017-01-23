import pyparsing as pp
from core.meta import WorldObjectClass

obj_ref = (
    pp.Optional(
        pp.Word(pp.nums).setResultsName("num") +
        pp.Optional(pp.Word(pp.alphas).leaveWhitespace()).suppress()
    )
    + pp.Word(pp.alphanums+"#").setResultsName("obj_name")
)


def find(what):
    res = obj_ref.parseString(what)
    omit = 0
    if res.num:
        omit = int(res.num)

    for cls, objects in WorldObjectClass.objects.items():
        for obj in objects.values():
            if obj.name == res.obj_name or obj._id == res.obj_name:
                if omit > 0:
                    omit -= 1
                    continue
                return obj

    omit = 0
    if res.num:
        omit = int(res.num)

    for cls, objects in WorldObjectClass.objects.items():  # NOQA
        for obj in objects.values():
            if obj.__class__.__name__.lower() == res.obj_name:
                if omit > 0:
                    omit -= 1
                    continue
                return obj

    return None
