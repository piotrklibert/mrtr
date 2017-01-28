sklep_odziezowy := Room makeNew

sklep_odziezowy do(
    setShort("Sklep odziezowy.")
    setLong("
        Wnetrze niewielkiego sklepu wypelniaja polki pelne poukladanych 
        wedlug rozmiarow pasow, helmow i karwaszy. Na pierwszy rzut oka widac, 
        ze wlasciciel podjal niemaly trud upchniecia duzej ilosci towaru na 
        zbyt malej przestrzeni, z sukcesem znajdujac miejsce w centrum pomieszczenia 
        dla oswietlonej gablotz z pelna zbroja o wartosci sentymentalno-historycznej.
        W glebi dostrzegasz lade, powyzej ktorej widnieje szyld napisem: 'Towar podaje sprzedawca'.
    " dedent)

    addItem("gablota", "
        Duza szklana gablota, w ktorej wyeksponowano zdobiona zbroje plytowa.
        Mimo, ze ten wieloelementowy pancerz lata nowosci ma juz za soba, pozostaje 
        nieodmiennie piekny dzieki misternie wykonanym zdobieniom i sladom swiadczacym 
        o jego niegdysiejszym uzywaniu. 
    " dedent)


    addEvent(45, "
        Pracownik sklepu zachwala towar niezdecydowanemu klientowi.
    " dedent)
    addEvent(45, "
        Klient szepce do zony:'Widzialas te ceny!? Chodzmy do domu.'
    " dedent)


    addExit("s", "grota.io")
)
