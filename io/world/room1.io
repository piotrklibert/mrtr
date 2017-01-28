room1 := Room makeNew

room1 do(
    setShort("Komorka na miotly.")
    setLong("
        Na kazdej plaskiej powierzchni w tym pomieszczeniu zalegl gruba na palec
        warstwa gesty kurz. Pod scianami widac wysokie i bardzo waskie metalowe
        szafki. Wiekszosc polek jest pusta i pokryta kurzem, jednak niektore
        szafki maja drzwiczki, zamkniete szczelnie i zablokowane klodkami. Nie
        ma tu okien ani widocznych zrodel swiatla, jedyne oswietlenie wpada przez
        drzwi wiodace na wschod, do glownego holu. W najdalszym od wejscia zakatku,
        wcisniete miedzy szafki tuz nad podloga, daje sie zauwazyc wejscie do
        jakiegos tunelu.
    ")

    addExit("tunel", "tunel1.io")
    addExit("e", "main_hall.io")


    # Items
    addItem("tunel", "
        Ciemna dziura w scianie na wysokosci podlogi, prawdopodobnie dosc duza,
        by sie przez nia przecisnac. Gdzies w glebi tunelu dostrzegasz swiatlo.
    ")
    addItem(["szafke", "szafki", "drzwiczki", "klodke", "klodki"], "
        TODO: napisac opis!
    ")
    # ----------------------------------------------------------------------


    # Actions
    addAction("otworz szafke", [
        "Usilujesz otworzyc pierwsza z brzegu szafke, ale niestety, nie udaje ci sie to.",
        "#{actor name} siluje sie przez chwile bez powodzenia z drzwiczkami szafki."
    ])
    addAction("wylam drzwiczki", [
        "Rozgladasz sie za czyms, czym moglbys wywazyc drzwiczki szafek, ale nie znajdujesz niczego takiego."
    ])
    # ----------------------------------------------------------------------


    # Events
    addEvent(145, "Ze strony tunelu zdaje sie przez chwile dobiegac metaliczne pobrzekiwanie.")
    addEvent(125, "
        Jedna z szafek zaczyna sie trzasc z gluchym grzechotem, jakby chciala
        wybiec z pokoju. Po chwili nieruchomieje jak pralka po skonczonym
        wirowaniu.
    " dedent)
    # ----------------------------------------------------------------------
)
