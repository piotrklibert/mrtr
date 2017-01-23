kuznia := Room makeNew

kuznia do(
	setShortName("Kuznia.")
    baseDesc := "
        Sklep prowadzony przez rod Von Klatz od pokolen. Muskularny 
        krasnolud patrzy na klientow zza drewnianej lady.
    " dedent

    addEvent(45, "
        Rozgrzane do czerwonosci palenisko skwierczy wesolo.
    " dedent)


    addExit("e", "grota.io")
)