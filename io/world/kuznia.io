kuznia := Room makeNew

kuznia do(
	setShort("Kuznia.")
    setLong("
        Sklep prowadzony przez rodzine Von Klatz od pokolen. W rogu, przy 
        rozgrzanym palenisku kowal obrabia kawalek metalu ciezkim mlotem.
        Wzdluz przeciwnej sciany pomieszczenia rozstawiono stojaki na gotowa 
        do sprzedazy bron. 
    " dedent)

    addEvent(45, "
        Rozgrzane do czerwonosci palenisko skwierczy wesolo.
    " dedent)
	addExitddEvent(35, "
        Kowal nuci przy pracy nierozpoznawalna melodie.
    " dedent)

    addExit("e", "grota.io")
)
