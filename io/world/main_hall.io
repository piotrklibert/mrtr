mainHall := Room makeNew

mainHall do(
    baseDesc := "
        Wielki Hol Glowny zostal zbudowany w swojej obecnej formie prawie
        na pewno wylacznie po to, by zaspokoic czyjas megalomanie. Dluga na
        ponad trzydziesci metrow i szeroka na dwadziescia ma ksztalt elipsy,
        z dziesiatkami rowno rozmieszczonych na scianach drzwi. Wiekszosc
        z drzwi jest zablokowana, niektore jednak sa uchylone i mozna sie przez
        nie przecisnac.
    " dedent

    addExit("w", "room1.io")
    addExit("s", "office.io")
)
