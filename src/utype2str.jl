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
v1 = [missing, "String"]


function type2str(x) #
    x <: Quantity && return q2str(x)
    return x |> Symbol |> string
end

function type2str(x::T) where T <: Union
    ts = Base.uniontypes(x)
    t2s = type2str.(ts)
    j = join(t2s, ", ")

    ut = "Union{$j}"
    return ut
end

function q2str(x)
    o = oneunit(x)
    os = string(o)
    us = string(ustrip(o))
    r = Regex("^$us ")
    u = replace(os, r=>"")
    m = replace(u, " "=>"*")
    ut = "typeof($(us)u\"$m\")"
    return ut
end



ts = type2str

@show t = ts(eltype(v))
# t = ts(eltype(v)) = "Union{Missing, typeof(1.0u\"J*m^-3\")}"

#
