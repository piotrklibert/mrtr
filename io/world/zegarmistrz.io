zegarmistrz := Room makeNew

zegarmistrz do(
    setShortName("Zegarmistrz.")
    baseDesc := "
        Szyld nad wejsciem glosi: 'Ku-Ku. Krasnoludzka Precyzja od 147 lat.'
        Otacza sie miarowe cykanie kilkudziesieciu zegarow, zbieranych i odrestaurowywanych przez bardzo cierpliwych ludzi przez lata.
    " dedent

    addEvent(25, "
        Cyk... cyk... cyk...
    " dedent)
    addEvent(45, "
        Ku-ku, ku-ku.
    " dedent)


    addExit("w", "grota.io")
)
