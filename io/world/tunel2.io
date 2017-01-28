tunel2 := Room makeNew

tunel2 do(
	setShort("W tunelu.")
    setLong("
    	Przejscie w kierunku polnocnym jest wyraznie wieksze.
    	Droga na poludnie pograzona jest w mroku.")


    addEvent(45, "
        Niedaleko slychac metaliczne pobrzekiwanie.
    " dedent)


    addExit("s", "tunel1.io")
    addExit("n", "grota.io")
)
