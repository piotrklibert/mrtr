zegarmistrz := Room makeNew

zegarmistrz do(
    setShort("Zegarmistrz.")
    setLong("
        Szyld nad wejsciem glosi: 'Ku-Ku. Krasnoludzka Precyzja od 147 lat.'
        Zewszad dochodzi miarowe cykanie wypelniajacych sciany starych zegarow.
        Ich stan swiadczy o pasji, ktorej bardzo cierpliwi ludzie poswiecali sie 
        przez lata.
    " dedent)

    addEvent(25, "
        Cyk... cyk... cyk...
    " dedent)
    addEvent(45, "
        Ku-ku, ku-ku.
    " dedent)


    addExit("w", "grota.io")
)
