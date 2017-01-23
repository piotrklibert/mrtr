room1 := Room makeNew

room1 do(
    setShortName("Komorka na miotly.")
    baseDesc := "
        Na kazdej plaskiej powierzchni zalegl gruba na palec warstwa gesty kurz.
        Pod scianami widac wysokie, choc waskie zaledwie na dwie stopy, metalowe
        szafki. Drzwiczki kazdej z nich zamkniete sa na klodke, kazda innego
        rodzaju. Migotliwe swiatlo zapewnia kilka imitacji oliwnych lampek
        rozwieszonych pod sufitem. Na wschodniej scianie znajduja sie drzwi,
        ktore prowadza do glownego holu. W najdalszym od wejscia zakatku,
        wcisniete miedzy szafki, widoczne jest wejscie do jakiegos tunelu...
    " dedent

    addItem("tunel", "
        Ciemna dziura w scianie. Gdzies w glebi tunelu dostrzegasz swiatlo.
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
