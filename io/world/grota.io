grota := Room makeNew

grota do(
    setShort("Grota.")
    setLong("
        Rozlegla kamienna grota o podswietlonym sklepieniu rzezbionym w fantazyjne
        wzory, jakie powstac mogly wylacznie dzieki niewatpliwemu szalenstwu 
        artysty. W glebi groty wykuto pomieszczenia uzytkowe lokalnego handlu.
    " dedent)


    addEvent(45, "Z zachodu dobiegaja odglosy obrabiania metalu.")
    addEvent(45, "Dobiega cie glos sprzedawcy zachwalajacego swoje towary.")


    addExit("e", "zegarmistrz.io")
    addExit("n", "sklep_odziezowy.io")
    addExit("w", "kuznia.io")
    addExit("s", "tunel2.io")
)
