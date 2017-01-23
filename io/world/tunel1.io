tunel1 := Room makeNew

tunel1 do(
	setShortName("W tunelu.")
    baseDesc := "
        Wyciosane wejscie w niezbyt dobrze oswietlony korytarz.
    " dedent

    
    addEvent(45, "
        Gdzies w oddali slychac metaliczne pobrzekiwanie.
    " dedent)
    

    addExit("tunel", "room1.io")
    addExit("n", "tunel2.io")
)