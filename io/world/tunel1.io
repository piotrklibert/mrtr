tunel1 := Room makeNew

tunel1 do(
	setShortName("Niski i waski tunel.")

    baseDesc := "
        Rozmiary tego przejscia - tunelu o przekroju kwadratu i scianach
        wykonanych z metalowych placht laczonych nitami - sprawiaja, ze trzeba
        sie niemal czolgac by sie przezen przedostac. Podloga opada pod ostrym
        katem w kierunku polnocnym, a kilka metrow dalej na polnoc tunel zaczyna
        sie rozszerzac, a mrok przejasniac. W przeciwnym kierunku tunel wiedzie
         stromo pod gore i w ciemnosc.
    " dedent


    addEvent(45, "
        Przez sciany tunelu przebiega drzenie, akompaniowane przez gluchy
        metaliczny zgrzyt.
    " dedent)

    addEvent(45, "
        Czyms poruszone powietrze owiewa cie lagodnie przez kilka chwil
        kierujac sie na polnoc.
    " dedent)

    addEvent(45, "
        Swiatlo poza wyjsciem z tunelu przygasa i migocze przez moment. Czyzby
        problemy z zasilaniem?
    " dedent)

    addExit("tunel", "room1.io")
    addExit("n", "tunel2.io")
)
