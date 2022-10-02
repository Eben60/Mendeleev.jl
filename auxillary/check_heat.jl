using Unitful

em = Mendeleev.chem_elements
a = Be.atomic_mass |> ustrip
s = Be.specific_heat |> ustrip
m = Be.molar_heat |> ustrip

r = m / (a*s)

ar = []
for e in em
    local a = e.atomic_mass |> ustrip
    local s = e.specific_heat |> ustrip
    local m = e.molar_heat |> ustrip
    local r = m / (a*s)
    local t = (;num=e.number, sym=e.symbol, cas=e.cas, mol = m, spc = s, dev = r)
    push!(ar, t)
end

sort!(ar, by=last)

filter!(x-> !(ismissing(x.dev) || isnan(x.dev)), ar)

function el(sym)
    d = findfirst(x -> (x.sym==sym), ar)
    isnothing(d) && return nothing
    return ar[d]
end

# julia> ar[1]
# (num = 82, sym = :Pb, dev = 0.8089288749666107)
#
# julia> ar[end]
# (num = 62, sym = :Sm, dev = 1.0914545830746947)

# TODO get NIST data
