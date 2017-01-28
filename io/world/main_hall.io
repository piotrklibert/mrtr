mainHall := Room makeNew

mainHall do(
    setShort("Sala glowna.")
    setLong("
        Plachty grubej, lekko przezroczystej folii budowlanej opasuja centrum
        pomieszczenia, wyznaczony w ten sposob owalny obszar zajmuje wiekszosc
        powierzchni sali tak, ze jedynie waski korytarz prowadzi wzdluz scian.
        Na foliowych zaslonach widnieje slowo 'REMONT', wypisane czerwona
        czcionka i powtorzone setki razy wzdluz calej dlugosci ogrodzenia. Z
        tego pomieszczenia najwyrazniej wiedzie bardzo wiele wyjsc, ale
        wiekszosc drzwi pozostaje zamknieta.
    ")

    addItem(["plachte", "plachty", "folie", "slowo", "napis"], "
        Grube, mleczne i lekko przezroczyste. plastikowe zaslony okalaja
        centralna czesc pomieszczenia i ukrywaja przed wzrokiem ciekawskich
        cokolwiek moze sie dziac za nimi.
    " dedent)
    addItem(["drzwi", "wyjscia", "wyjscie"], "TODO")
    addItem(["korytarz"], "TODO")

    addEvent(145, "Jakis zagubiony podmuch wiatru szelesci w zaslonach.")
    addEvent(145, "W powietrzu unosi sie zapach cementu, betonu i gruzu.")
    addEvent(145, "Cos ciezkiego i najwyrazniej metalowego laduje z brzekiem na podlodze.")
    addEvent(145, "TODO...")

    addAction(["spojrz za zaslone", "zerknij za zaslone", "spojrz za placht"], [
        "Bez wiekszego trudu udaje ci sie odchylic jedna z placht, spogladajac do srodka. Widzisz: TODO",
        "#{actor name} odchyla jedna z plach i zaglada za nia."
    ])


    addExit("n", "cji/workroom.io")
    addExit("w", "room1.io")
    addExit("s", "office.io")
)
# Wielki Hol Glowny zostal zbudowany w swojej obecnej formie prawie
# na pewno wylacznie po to, by zaspokoic czyjas megalomanie. Dluga na
# ponad trzydziesci metrow i szeroka na dwadziescia ma ksztalt elipsy,
# z dziesiatkami rowno rozmieszczonych na scianach drzwi. Wiekszosc
# z drzwi jest zablokowana, niektore jednak sa uchylone i mozna sie przez
# nie przecisnac. Jedne szczegolnie okazale drzwi zwracaja uwage na
# polnocnej scianie sali.
