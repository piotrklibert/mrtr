office := Room makeNew

office do(
    setShort("Kantor.")
    setLong("
        To jasne pomieszczenie zostalo bardzo dokladnie przystosowane do 
        przetrzymywania sporej ilosci gotowki. Przez przezroczysta sciane z magicznego 
        szkla, dla bezpieczenstwa wzmocniona mithrylowymi pretami, widac ogromne,
        metalowe drzwi do skarbca. Jedyny kontakt z eleganckim mezczyzna po drugiej 
        stronie sciany mozliwy jest przez niewielkie okienko z szufladka do podawania
        pieniedzy.
    " dedent)


    addItem("okienko", "
        Przeszklone, nieskazitelnie czyste okienko kantoru. Mala szufladka umozliwia
        przekazanie pieniedzy do wymiany.
    " dedent)


    addEvent(45, "
        Stojacy nieopodal mezczyzna wczytuje sie w ulotke z napisem: DOBRY KREDYT!
    " dedent)
    addEvent(30, "
        Grupka ludzi przechodzi w pospiechu przez drzwi wejsciowe.
    " dedent)


    addExit("n", "main_hall.io")
)
