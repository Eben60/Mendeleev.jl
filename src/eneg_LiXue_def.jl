
struct LiXueDSet
    atomic_number::Int
    charge::Int
    coordination::Symbol
    spin::Union{Symbol, Missing}
    value::typeof(1.0*u"1/pm")
end

LiXueDSet(atomic_number, charge, coordination, spin, value::Real) = 
    LiXueDSet(atomic_number, charge, coordination, spin, value*u"1/pm")

LiXueDSet(atomic_number, charge, t::Tuple) = LiXueDSet(atomic_number, charge, t...)

Base.show(io::IO, lx::LiXueDSet) = showpresent(io::IO, lx, [:coordination, :spin, :value])

# lxd = LiXueDSet(1, 1, (:II, missing, -21.244330519873465))

struct LiXue
    data::Vector{LiXueDSet}
end

function Base.show(io::IO, lx::LiXue)
    println(io, "Li-Xue Electronegativities for $(chem_elements[lx.data[1].atomic_number].symbol)")
    for d in lx.data
        println(io, "    $d")
    end
end

lxv(d, atomic_number, charge) = [LiXueDSet(atomic_number, charge, t) for t in d[charge]]

function LiXue(d::Dict, atomic_number)
    data = Dict(charge => lxv(d, atomic_number, charge) for charge in keys(d))
    data = vcat(values(data)...)
    return LiXue(data)
end 

lx_or_missing(atomic_number::Integer) = ismissing(lixue_data[atomic_number]) ? missing : LiXue(lixue_data[atomic_number], atomic_number)

fs_eq_or_nothing(x; kwargs...) = 
    all([(isnothing(v) || (!ismissing(getfield(x, k)) && v == getfield(x, k))) for (k,v) in kwargs])

(lx::LiXue)(; charge=nothing, coordination=nothing, spin=nothing) = 
    [x for x in lx.data if fs_eq_or_nothing(x; charge, coordination, spin)]

    # filter(x -> fs_eq_or_nothing(x; charge, coordination, spin), lx.data)
