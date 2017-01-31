kuznia := Room makeNew

kuznia do(
	setShort("Smithy.")
    setLong("
        A blacksmith hot workplace, run by Von Klatz family for generations.
        High temperature comes from hearth used to heat pieces of metal.
        Just by it, on heavy anvil, a well-built smith shapes his workpiece
        with a huge hammer. Allong the opposite wall of workshop stands
        with ready to sell weapons are placed.
    " dedent)

    addEvent(145, "
        The red-hot furnace sizzles, spitting sparks.
    " dedent)
	addEvent(135, "
        Well-built smith is humming the unrecognizable tune.
    " dedent)
    addEvent(135, "
        Some customer performs a trial swings with his new sword.
    " dedent)

# setShort("Kuznia.")
#     setLong("
#         Warsztat prowadzony przez rodzine Von Klatz od pokolen. W rogu, przy
#         rozgrzanym palenisku kowal obrabia kawalek metalu ciezkim mlotem.
#         Wzdluz przeciwnej sciany pomieszczenia rozstawiono stojaki na gotowa
#         do sprzedazy bron.
#     " dedent)

#     addEvent(45, "
#         Rozgrzane do czerwonosci palenisko skwierczy wesolo.
#     " dedent)
#     addEvent(35, "
#         Kowal nuci przy pracy nierozpoznawalna melodie.
#     " dedent)

    addExit("e", "grota.io")
)
