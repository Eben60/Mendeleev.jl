using Unitful

# a = 1.1u"J/m^3"
# TA = typeof(a)
# # o = TA(1.0)
# # o1 = oneunit(o)
# o = oneunit(TA);
# os = string(o)
# @show os
#
# firstsp = r"^\d.+? "
#
# m = match(firstsp, os)
#
# os2 = replace(os, firstsp => "")
# os3 = replace(os2, " "=>"*")
#
# ut = "typeof(u\"$os3\")"
#
# mp = Meta.parse(ut)
#
# e = eval(Meta.parse(ut))

v = [missing, 1.1u"J/m^3"]


function type2str(x)
    Tx = typeof(x)
    ts = Base.uniontypes(Tx)

    return (;ut, os, us, u, m)
end


function type2str(x::T) where T <: Union
    Tx = typeof(x)
    ts = Base.uniontypes(Tx)

    return (;ut, os, us, u, m)
end

function type2str(x::T) where T <: Quantity
    Tx = typeof(x)
    o = oneunit(Tx)
    os = string(o)
    us = string(ustrip(o))
    r = Regex("^$us ")
    u = replace(os, r=>"")
    m = replace(u, " "=>"*")
    ut = "typeof($(us)u\"$m\")"
    return (;ut, os, us, u, m)
end



ts = type2str

#
