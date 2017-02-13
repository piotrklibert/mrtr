cji_workroom := Room makeNew do(
    setShort("Instytut Magii Wyzszych Energii")
    setLong("
        Mimo iz pokoj, w ktorym sie obecnie znajdujesz, jest dosc spory -
        przynajmniej dziesiec krokow dlugi i tak samo szeroki - to jest tak
        zawalony rozmaitymi szpargalami, ze znalezienie chocby kawalka wolnej
        podlogi jest wyzwaniem. Przynajmniej trzy biurka uginaja sie pod
        ciezarem papierzysk, usypanych w gory o alpejskiej wrecz skali. Na
        jedynym fotelu, dziwnie wcisniety miedzy oparcie a podlokietniki,
        postanowil spoczac rower. Na parapecie jedynego okna stoja doniczki z
        pokaznych rozmiarow kaktusami i sukulentami. To wszystko jednak stanowi
        zaledwie tlo dla pokaznej tablicy, z odrecznie wypisanym mamucimi
        literami zawolaniem bojowym: 'IT'S A DEFEAT IF YOU MIND IT!'. Drzwi na
        poludniowej scianie pokoju, wcisniete miedzy polki z ksiazkami i
        strzelisty (choc chwiejny) stos ubran, prowadza do Wielkiego Holu.
    ")


    addItem(["tablice", "napis", "litery"], PRE : "
         ___ _____ _ ____        _       ____  _____ _____ _____    _  _____
        |_ _|_   _( ) ___|      / \\     |  _ \\| ____|  ___| ____|  / \\|_   _|
         | |  | | |/\\___ \\     / _ \\    | | | |  _| | |_  |  _|   / _ \\ | |
         | |  | |    ___) |   / ___ \\   | |_| | |___|  _| | |___ / ___ \\| |
        |___| |_|   |____/   /_/   \\_\\  |____/|_____|_|   |_____/_/   \\_\\_|

         ___ _____   __   _____  _   _    __  __ ___ _   _ ____     ___ _____ _
        |_ _|  ___|  \\ \\ / / _ \\| | | |  |  \\/  |_ _| \\ | |  _ \\   |_ _|_   _| |
         | || |_      \\ V / | | | | | |  | |\\/| || ||  \\| | | | |   | |  | | | |
         | ||  _|      | || |_| | |_| |  | |  | || || |\\  | |_| |   | |  | | |_|
        |___|_|        |_| \\___/ \\___/   |_|  |_|___|_| \\_|____/   |___| |_| (_) ")


    addExit("s", "main_hall.io")
)
