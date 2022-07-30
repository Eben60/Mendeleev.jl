struct Group_M
    symbol::String
    name::String
end

function group_fullname(g::Group_M)
    name = g.name
    symbol = g.symbol
    isempty(name) && return symbol
    return "$symbol ($name)"
end


function Base.show(io::IO, g::Group_M)
    show(group_fullname(g))
end

groups_m = (
Group_M("IA", "Alkali metals"),
Group_M("IIA", "Alkaline earths"),
Group_M("IIIB", ""),
Group_M("IVB", ""),
Group_M("VB", ""),
Group_M("VIB", ""),
Group_M("VIIB", ""),
Group_M("VIIIB", ""),
Group_M("VIIIB", ""),
Group_M("VIIIB", ""),
Group_M("IB", "Coinage metals"),
Group_M("IIB", ""),
Group_M("IIIA", "Boron group"),
Group_M("IVA", "Carbon group"),
Group_M("VA", "Pnictogens"),
Group_M("VIA", "Chalcogens"),
Group_M("VIIA", "Halogens"),
Group_M("VIIIA", "Noble gases"),
)
