heartbeat := Object clone do(
    counter := 0

    singleStep := method(
        self counter := self counter + 1
        "." print
        if(self counter > 9,
            self counter := 0
            writeln)
    )

    start := method(
        self last := Date now asNumber
        loop(
            now := Date now asNumber
            self singleStep
            wait(1)
            self last := Date now asNumber
        )
    )
)
