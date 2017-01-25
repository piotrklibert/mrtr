tunel2 := Room makeNew

tunel2 do(
	setShortName("W tunelu.")
    baseDesc := "
        Wyciosany w skale korytarz.
    " dedent


    addEvent(45, "
        Niedaleko slychac metaliczne pobrzekiwanie.
    " dedent)


    addExit("s", "tunel1.io")
    addExit("n", "grota.io")
)
