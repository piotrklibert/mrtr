LogBackend := Object clone do(
    # TODO: add configuration
    defattr(out, nil)

    with := method(outFile,
        self clone setOut(outFile)
    )
)

Log := Object clone do(
    forward := method()
)
