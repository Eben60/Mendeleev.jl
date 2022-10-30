
struct LiXue_dset
    atomic_number::Int
    charge::Int
    coordination::Symbol
    spin::Union{Symbol, Missing}
    value::typeof(1.0*u"1/pm")
end

LiXue_dset(atomic_number, charge, coordination, spin, value::Real) = 
    LiXue_dset(atomic_number, charge, coordination, spin, value*u"1/pm")

LiXue_dset(atomic_number, charge, t::Tuple) = LiXue_dset(atomic_number, charge, t...)

lxd = LiXue_dset(1, 1, (:II, missing, -21.244330519873465))

struct LiXue
    data::Vector{LiXue_dset}
end

lxv(d, atomic_number, charge) = [LiXue_dset(atomic_number, charge, t) for t in d[charge]]

function LiXue(d::Dict, atomic_number)
    data = Dict(charge => lxv(d, atomic_number, charge) for charge in keys(d))
    data = vcat(values(data)...)
    return LiXue(data)
end 

lx_or_missing(atomic_number::Integer) = ismissing(lixue_data[atomic_number]) ? missing : LiXue(lixue_data[atomic_number], atomic_number)

