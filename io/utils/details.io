ObjectDetail := Object clone do(
    with := method(name, desc,
        cln := self clone
        cln name := if(name isKindOf(List) not, [name], name)
        cln desc := desc dedent
        cln
    )
    asString := method(
        (self == ObjectDetail) ifTrue(
            return "<ObjectDetail: name='' desc=''>"
        )
        name := self name first
        desc := self desc exSlice(0, 35)
        dots := if(self desc size > 35, "...", "")
        "<ObjectDetail: name='#{name}', desc='#{desc}#{dots}'>" interpolate
    )
)
