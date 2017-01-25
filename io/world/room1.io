room1 := Room makeNew

room1 do(
    setShortName("Komorka na miotly.")
    baseDesc := "
        Na kazdej plaskiej w tym pomieszczeniu powierzchni zalegl gruba na palec
        warstwa gesty kurz. Pod scianami widac wysokie i bardzo waskie metalowe
        szafki. Wiekszosc polek jest pusta i pokryta kurzem, jednak niektore
        szafki maja drzwiczki, zamkniete szczelnie i zablokowane klodkami. Nie
        ma tu okien ani widocznych zrodel swiatla, jedyne oswietlenie wpada przez
        drzwi wiodace na wschod, do glownego holu. W najdalszym od wejscia zakatku,
        wcisniete miedzy szafki na wysokosci podlogi, widoczne jest wejscie do
        jakiegos tunelu.
    " dedent

    addItem("tunel", "
        Ciemna dziura w scianie na wysokosci podlogi, prawdopodobnie dosc duza,
        by sie przez nia przecisnac. Gdzies w glebi tunelu dostrzegasz swiatlo.
    " dedent)

    addEvent(145, "
        Ze strony tunelu zdaje sie przez chwile dobiegac metaliczne pobrzekiwanie.
    " dedent)
    addEvent(125, "
        Jedna z szafek zaczyna sie trzasc z gluchym grzechotem, jakby chciala
        wybiec z pokoju. Po chwili nieruchomieje jak pralka po skonczonym
        wirowaniu.
    " dedent)

    defcmd(a, beginsWithSeq("otworz"),
        actor out writeln("
            Usilujesz otworzyc pierwsza z brzegu szafke, ale niestety, nie
            udaje Ci sie to.
        " dedent)
    )

    addExit("tunel", "tunel1.io")
    addExit("e", "main_hall.io")
)
