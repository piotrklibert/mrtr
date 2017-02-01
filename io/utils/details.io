
ObjectDetail := Object clone do(
    with := method(name, desc,
        cln := self clone
        cln name := if(name isKindOf(List) not, [name], name)
        cln desc := desc dedent
        cln
    )
    asString := method(
        name := self name first
        desc := self desc slice(0, 35)
        dots := if(self desc size > 35, "...", "")
        "<ObjectDetail: name='#{name}', desc='#{desc}#{dots}'>" interpolate
    )
)
