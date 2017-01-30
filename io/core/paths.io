Directory walk := method(
    # We call a given message on each file in the directory, being walked...
    call delegateToMethod(
        items select(item, item name != "." and item name !=".."), "map"
    )
    # .. and then recursively walk all subdirectories, if there is any.
    if(directories size > 0,
        yield
        directories map(dir, call delegateTo(dir))
    )
    nil
)


Paths := Object clone do(
    currentDir := Directory with(System launchPath)
    stdDir     := currentDir directoryNamed("std")
    worldDir   := currentDir directoryNamed("world")

    isJunk := method(file,
        (file isKindOf(File) or file isKindOf(Directory)) ifTrue(
            file := file name
        )
        file beginsWithAnyOf(".", "#")
    )
    cd := method(dir,
        self currentDir := currentDir directoryNamed(dir)
        self
    )
    cwd := method(dir, self clone cd(dir))
    ls := method(
        dirs := currentDir directories
        entries := dirs appendSeq(currentDir files)
        entries select(e, isJunk(e) not)
    )
    files := method(
        currentDir recursiveFilesOfTypes(
            list("io")
        ) select(name )
    )
    findAll := method(what,
        re := (".*" .. what .. ".*") asRegex
        currentDir files select(fname, re matches(fname name))
    )
    find := method(what,
        self findAll(what) at(0)
    )
)
