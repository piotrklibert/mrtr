class Room(Container):          # NOQA
    auto_instantiate = True
    class defaults(Container.defaults):  # NOQA
        name = "room"
        short = "a room"
        base_desc = "A room."
        container_desc = "You see items here: "
