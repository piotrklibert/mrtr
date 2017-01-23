import uuid
import funcy as fn
import re
import logging
log = logging.getLogger(__name__)


def dedent(s):
    import textwrap
    l = s.splitlines()
    if len(l) > 1:
        l = l[1:-1]
    return textwrap.dedent("\n".join(l))


class DefaultsClass(type):

    def __new__(_type, name, bases, dic, **kwargs):
        log = logging.getLogger("object.DefaultsClass")

        def is_str_attr(el):
            assert not isinstance(el, str), "list or tuple expected"
            ret = (
                not el[0].startswith("_") and isinstance(el[1], str)
            )
            return ret

        attrs = list(filter(is_str_attr, dic.items()))
        log.debug("Creating defaults %s, %s, %s", name, bases, attrs)
        attrs = list(map(lambda el: (el[0], dedent(el[1])), attrs))
        cls = super().__new__(_type, name, bases,
                              fn.merge(dic, dict(attrs)),
                              **kwargs)
        log.debug("...created: %s",
                  list(filter(is_str_attr, cls.__dict__.items())))
        return cls

    def __get__(self, instance, owner):
        defaults = self
        if instance:
            class DefaultsWrapper:
                def __getattr__(self, name):
                    f = getattr(defaults, name)
                    if callable(f):
                        return f(instance)
                    else:
                        return f
            return DefaultsWrapper()
        else:
            return self


class WorldObject(metaclass=WorldObjectClass):  # NOQA
    """The most fundamental attributes of this class:

        * _id
        * _parent

        * name
        * short
        * desc

    On the created object the last three attributes are *always*
    properties.

    There are many ways of customizing the last three attributes:

    1. When defining a class, you can define these attrs as:

        * strings. String value is then copied to self.'_'+attr_name,
        where default property implementation looks for data.

        * methods. They will be converted to properties automatically.

        * properties. As with methods, only conversion to property is
        explicit.

    2. When defining a class, you can define 'defaults' attribute as
    a dictionary. Default implementation searches `self.defaults` if
    there is no `self._attr_name` defined.

    3. When instantiating an object, you can pass keyword args with
    strings. They will be stored in `self._attr_name`.
    """

    class defaults(metaclass=DefaultsClass):
        def name(obj):
            if obj:
                return obj.__class__.__name__.lower() + "#" + obj._id
            else:
                return '--name--error--'

        short = "A simple object without description."
        desc = """
            This is an object.
            It has no description, this is the default message.
        """

    def generate_uuid(self):
        return str(uuid.uuid4().hex)

    def __init__(self, **kwargs):
        self._parent = None
        self._id = self.generate_uuid()
        log.debug("Initializing obj: %s#%s", self.__class__.__name__, self._id)

        for attr in ["name", "short", "desc"]:
            val = kwargs.get(attr)

            if val:
                setattr(self, "_"+attr, val)

        self._register_object_creation()

    def _register_object_creation(self):
        cls = self.__class__
        cls._objects[cls][self._id] = self

    def move(self, obj):
        parent = self._parent
        if parent:
            parent.rm(self)
        obj.add(self)
        assert self._parent == obj
        return self

    def get_command_matchers(self):
        # XXX TODO
        return []

    def do_cmd(self, cmdline):
        matchers = (
            self.get_command_matchers() +
            self._parent.get_command_matchers() +
            COMMANDS.get_command_matchers()
        )
        for matcher in matchers:
            res = matcher(cmdline)
            if res:
                return res()
        return None

    @property
    def name(self):
        return getattr(self, "_name", None) or self.defaults.name

    @property
    def short(self):
        return getattr(self, "_short", None) or self.defaults.short

    @property
    def desc(self):
        return getattr(self, "_desc", None) or self.defaults.desc

    def __repr__(self):
        return "<{}: {}>".format(self.__class__.__name__, self.name)

    def __str__(self):
        return repr(self)
