office := Room makeNew

office do(
    setShort("Currency exchange.")
    setLong("
        This bright room was carefully designed and adapted to keep large amounts 
        of cash safe. A huge metal door to the vault can be seen through 
        transparent wall of magic glass, reinforced - for more protection - with 
        mithryl rods. Contact with an elegant man on the other side is possible
        only through small drawer, adapted to pass money. The walls are covered 
        with pictures of monetary units.
    " dedent)


    addItem("drawer", "
        A sliding compartment, open on its top, that can be pulled to access to 
        its content more easily.
    " dedent)
    addItem("wall", "
        Flawlessy clean, transparent wall made of magic glass, reinforced with 
        mithryl rods. This glass is distinguished above all by its indestructibility
        and resistance to magic attacks.
    " dedent)

    addEvent(45, "
        A man standing against the wall takes informational brochure with 
        inscription: BEST LOAN!
    " dedent)
    addEvent(30, "
        Group of people rush out through main door.
    " dedent)

# setShort("Kantor.")
#     setLong("
#         To jasne pomieszczenie zostalo bardzo dokladnie przystosowane do 
#         przetrzymywania sporej ilosci gotowki. Przez przezroczysta sciane z magicznego 
#         szkla, dla bezpieczenstwa wzmocniona mithrylowymi pretami, widac ogromne,
#         metalowe drzwi do skarbca. Jedyny kontakt z eleganckim mezczyzna po drugiej 
#         stronie sciany mozliwy jest przez nietypowe okienko - nieokratowana czesc szyby z umieszczona 
#         w blacie ponizej szufladka do podawania pieniedzy.
#     " dedent)

#     addItem("okienko", "
#         Nieskazitelnie czysta szklana tafla, charakteryzujaca sie niezniszczalnoscia 
#         i odpornoscia na magiczne ataki. Mala szufladka, wpasowana w marmurowy 
#         kontuar, umozliwia przekazanie pieniedzy do wymiany.
#     " dedent)

#     addEvent(45, "
#         Stojacy pod sciana mezczyzna wczytuje sie w ulotke z napisem: DOBRY KREDYT!
#     " dedent)
#     addEvent(30, "
#         Grupka ludzi przechodzi w pospiechu przez drzwi wejsciowe.
#     " dedent)

    addExit("n", "main_hall.io")
)
