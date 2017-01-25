sklep_odziezowy := Room makeNew

sklep_odziezowy do(
    setShortName("Sklep odziezowy.")
    baseDesc := "
        Wnetrze wypelniaja polki pelne poukladanych rozmiarami misiurek, helmow i karwaszy.
        W centralnej czesci sklepu znajduja sie stojaki z rozwieszonymi na nich zbrojami.
        Z tylu dostrzegasz lade, powyzej ktorej widnieje szyld napisem: 'Towar podaje sprzedawca'.
    " dedent

    addEvent(45, "
        Namolny pracownik sklepu zachwala towar niezdecydowanemu klientowi.
    " dedent)
    addEvent(45, "
        Klient szepce do zony:'Widzialas te ceny!? Chodzmy do domu.'
    " dedent)


    addExit("s", "grota.io")
)
