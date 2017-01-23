grota := Room makeNew

grota do(
    setShortName("Grota.")
    baseDesc := "
        Duza grota o wysokim sklepieniu, tworzaca centralna sale kompleksu tuneli podmiejskich. Jej dosc dobrze oswietlone wnetrze ukazuje wykute w skale pomieszczenia, przeznaczone na rzecz lokalnego handlu.
    " dedent

    addEvent(45, "
        Z zachodu dobiegaja odglosy obrabiania metalu.
    " dedent)
    addEvent(45, "
        Dobiega cie glos sprzedawcy zachwalajacego swoje towary.
    " dedent)


    addExit("e", "zegarmistrz.io")
    addExit("n", "sklep_odziezowy.io")
    addExit("w", "kuznia.io")
    addExit("s", "tunel2.io")
)