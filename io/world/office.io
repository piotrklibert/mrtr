office := Room makeNew

office do(
    baseDesc := "
        To jest jakies biuro. Wyglada bardziej na komorke na miotly, ale ma
        kawalek okna.
    " dedent


    addItem("okno", "
        Okno to troche za duzo powiedziane: dziura w murze, przeslonieta
        cienka, zachlapana blotem tektura. Przez brud i syf nie sposob nic
        zobaczyc.
    " dedent)


    addEvent(45, "
        Po drewnianej podlodze przemknal cien, wielkosci dloni i dosc wlochaty.
        To mogl byc szczur, ale szczury zazwyczaj nie maja az tylu nog...
    " dedent)
    addEvent(30, "
        Cos uderzylo w tekture okna od zewnatrz, wydajac z siebie
        przerazliwy pisk. Pisk urywa sie nagle.
    " dedent)
    addEvent(30, "
        Grupka ludzi przechodzi w pospiechu przez glowny hol, mijajac drzwi
        do pokoju.
    " dedent)


    addExit("n", "main_hall.io")
)
