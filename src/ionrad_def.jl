
const e_charge = Unitful.q # elementary charge 
"""
    IonicRadius
This struct describes ionic radius for a given charge state of a given element. 
It is not exported.
```
    atomic_number::Int
    charge::Int
    coordination::Symbol
    crystal_radius::Float64
    econf::Union{String, Missing}
    ionic_radius::Float64
    most_reliable::Union{Bool, Missing}
    origin::Union{String, Missing}
    spin::Union{Symbol, Missing}
```    
"""
struct IonicRadius
    atomic_number::Int
    charge::Int
    coordination::Symbol
    crystal_radius::typeof(1.0u"pm")
    econf::Union{String, Missing}
    ionic_radius::typeof(1.0u"pm")
    most_reliable::Union{Bool, Missing}
    origin::Union{String, Missing}
    spin::Union{Symbol, Missing}
    ionic_potential::typeof(1.0u"C"/u"m")
end 

ionic_potential(ion_rad, charge) = charge*e_charge/ion_rad

function IonicRadius(atomic_number::Integer, row::Integer)
    args = [v[row] for v in ionrad_data]
    args[3] *= u"pm"
    args[5] *= u"pm"
    ion_rad = args[5]
    charge = args[1]
    ip = ionic_potential(ion_rad, charge) 
    all_args = vcat(atomic_number, args, ip)
    return IonicRadius(all_args...)
end

function Base.isless(sc1::IonicRadius, sc2::IonicRadius)
    sc1.atomic_number != sc2.atomic_number && throw(DomainError("cannot compare IonicRadius for different elements"))
    return sc1.charge < sc2.charge
end

# IonicRadii equality is determined by atomic number and charge
Base.isequal(ir1::IonicRadius, ir2::IonicRadius) = (ir1.atomic_number, ir1.charge) == (ir2.atomic_number, ir2.charge)


struct IonicRadii
    atomic_number::Int
    data::Vector{IonicRadius}
    IonicRadii(data::Vector{IonicRadius}) = new(
        data[1].atomic_number,
        sort!(data) )
end

function IonicRadii(atomic_number::Integer)
    range = ionrad_ranges[atomic_number]
    ismissing(range) && return missing
    range = range[begin] : range[end]
    radii = [IonicRadius(atomic_number, r) for r in range]  
    return IonicRadii(radii)
end

IonicRadii(e::ChemElem) = IonicRadii(e.atomic_number)

# end