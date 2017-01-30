sklep_odziezowy := Room makeNew


sklep_odziezowy do(
    setShort("Clothing store.")
    setLong("
        All walls of this room are full of shelves with gloves, lanes, helmets
        and other leather and metal body protectors, all organised by sizes.
        It looks like the owner took time and trouble to place a great amount of
        merchandise on shelves capacity, and to exhibit in the center of store
        an old full plate armor in a shiny glass vitrine.
    " dedent)

    addItem("vitrine", "
        A glass container used to store and display items in a shop. There is
        an armor inside it.
    " dedent)
    addItem("armor", "
        You're looking at historical type of personal armor made from steel
        plates, entirely encasing the wearer. Although it best days are over,
        it remains invariably beautiful - due to detailed ornaments and marks
        of erstwhile use.
    " dedent)

    addEvent(45, "
        Store employee praises some products to hesistant customer.
    " dedent)
    addEvent(5, "
        Tall skinny man tries on lether glove.
    " dedent)
    addEvent(45, "
        A few new clients came in to the shop.
    " dedent)

# setShort("Sklep odziezowy.")
#     setLong("
#         Wnetrze niewielkiego sklepu wypelniaja polki pelne poukladanych
#         wedlug rozmiarow pasow, helmow i karwaszy. Na pierwszy rzut oka widac,
#         ze wlasciciel podjal niemaly trud upchniecia duzej ilosci towaru na
#         zbyt malej przestrzeni, z sukcesem znajdujac miejsce w centrum pomieszczenia
#         dla oswietlonej gablotz z pelna zbroja o wartosci sentymentalno-historycznej.
#         W glebi dostrzegasz lade, powyzej ktorej widnieje szyld napisem: 'Towar podaje sprzedawca'.
#     " dedent)

#     addItem("gablota", "
#         Duza szklana gablota, w ktorej wyeksponowano zdobiona zbroje plytowa.
#         Mimo, ze ten wieloelementowy pancerz lata nowosci ma juz za soba, pozostaje
#         nieodmiennie piekny dzieki misternie wykonanym zdobieniom i sladom swiadczacym
#         o jego niegdysiejszym uzywaniu.
#     " dedent)

#     addEvent(45, "
#         Pracownik sklepu zachwala towar niezdecydowanemu klientowi.
#     " dedent)
#     addEvent(45, "
#         Klient szepce do zony:'Widzialas te ceny!? Chodzmy do domu.'
#     " dedent)

    addExit("s", "grota.io")
)
