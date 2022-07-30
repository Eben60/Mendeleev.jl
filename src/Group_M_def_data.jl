struct Group_M
    no::Int
    symbol::String
    name::String
end

function group_fullname(g::Group_M)
    no = g.no
    name = g.name
    symbol = g.symbol
    isempty(name) && return "$no - $symbol"
    return "$no - $symbol ($name)"
end


function Base.show(io::IO, g::Group_M)
    show(group_fullname(g))
end

groups_m = (
Group_M(1, "IA", "Alkali metals"),
Group_M(2, "IIA", "Alkaline earths"),
Group_M(3, "IIIB", ""),
Group_M(4, "IVB", ""),
Group_M(5, "VB", ""),
Group_M(6, "VIB", ""),
Group_M(7, "VIIB", ""),
Group_M(8, "VIIIB", ""),
Group_M(9, "VIIIB", ""),
Group_M(10, "VIIIB", ""),
Group_M(11, "IB", "Coinage metals"),
Group_M(12, "IIB", ""),
Group_M(13, "IIIA", "Boron group"),
Group_M(14, "IVA", "Carbon group"),
Group_M(15, "VA", "Pnictogens"),
Group_M(16, "VIA", "Chalcogens"),
Group_M(17, "VIIA", "Halogens"),
Group_M(18, "VIIIA", "Noble gases"),
)
