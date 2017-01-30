zegarmistrz := Room makeNew


zegarmistrz do(
    setShort("Clockmaker shop.")
    setLong("
        Signboard above entrance says: COCKOO - 150 YEARS OF PRECISION.
        Walls are covered with all kinds of clocks - from large wooden ones
        driven by pendulum, through hanging ones with weights, to smart stylish
        wrist-watches, closed in glass showcase. They look well-kept and
        regulary maintained by people full of passion, patience and steady hands.
        The room is filled by silent ticking.
    " dedent)

    addEvent(25, "
        Tick... tack... tick...
    " dedent)
    addEvent(45, "
        The owner cleans hanprints from glass counter with soft piece of cloth.
    " dedent)

# setShort("Zegarmistrz.")
#     setLong("
#         Szyld nad wejsciem glosi: 'Ku-Ku. Krasnoludzka Precyzja od 147 lat.'
#         Zewszad dochodzi miarowe cykanie wypelniajacych sciany starych zegarow.
#         Ich stan swiadczy o pasji, ktorej bardzo cierpliwi ludzie poswiecali sie
#         przez lata.
#     " dedent)

#     addEvent(25, "
#         Cyk... cyk... cyk...
#     " dedent)
#     addEvent(45, "
#         Ku-ku, ku-ku.
#     " dedent)

    addExit("w", "grota.io")
)
