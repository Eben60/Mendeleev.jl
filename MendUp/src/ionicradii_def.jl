"""
    IonicRadius
This struct describes ionic radius for a given charge state of a given element. 
It is not exported.
```
    atomic_number::Int
    charge::Int
    coordination::Symbol
    crystal_radius::Float64
    econf::String
    ionic_radius::Float64
    most_reliable::Bool
    origin::String
    spin::Symbol
```    
"""
struct IonicRadius
    atomic_number::Int
    charge::Int
    coordination::Symbol
    crystal_radius::Float64
    econf::Union{String, Missing}
    ionic_radius::Float64
    most_reliable::Union{Bool, Missing}
    origin::Union{String, Missing}
    spin::Union{Symbol, Missing}
end   

function symbormiss(x)
    (ismissing(x) || x == "") && return missing
    return Symbol(x)
end

function strormiss(x) 
    (ismissing(x) || x == "") && return missing
    return string(x)
end

boolormiss(x) = ismissing(x) ? x : Bool(x)

IonicRadius(an, ch, co::AbstractString, cr, ec::Union{AbstractString, Missing}, ir, mr, or, sp::Union{AbstractString, Missing}) = 
    IonicRadius(an, ch, symbormiss(co), cr, strormiss(ec), ir, mr, strormiss(or), symbormiss(sp)) 

IonicRadius(t::T) where T <: Tuple = IonicRadius(t...)

IonicRadius(; atomic_number, charge, coordination, crystal_radius, econf, ionic_radius, most_reliable, origin,spin) = 
    IonicRadius(atomic_number, charge, coordination, crystal_radius, econf, ionic_radius, most_reliable, origin,spin)

# function Base.show(io::IO, sc::ScreenConst)
#     elem = chem_elements[sc.atomic_number].symbol
#     orb_type = orb_typenames[sc.orb_type]
#     orbital = "$(sc.shell)$orb_type"
#     print(io, "$elem $orbital: $(sc.screening)")
# end

function Base.isless(sc1::IonicRadius, sc2::IonicRadius)
    sc1.atomic_number != sc2.atomic_number && throw(DomainError("cannot compare IonicRadius for different elements"))
    return sc1.charge < sc2.charge
end

# IonicRadii equality is determined by atomic number and charge
Base.isequal(ir1::IonicRadius, ir2::IonicRadius) = (ir1.atomic_number, ir1.charge) == (ir2.atomic_number, ir2.charge)

"""
    IonicRadii
This struct is a container for ionic radii of an element. See examples below for indexing access. 
It is not exported.

# Examples
# ```julia-repl
# julia> chem_elements[:Mo].sconst[2, 1]
# Mo 2s: 11.1232

# julia> chem_elements[:Mo].sconst[2, 's']
# Mo 2s: 11.1232

# julia> chem_elements[:Mo].sconst[2, "s"]
# Mo 2s: 11.1232

# julia> chem_elements[:Mo].sconst["2s"]
# Mo 2s: 11.1232
# ```
"""  
struct IonicRadii
    atomic_number::Int
    data::Vector{IonicRadius}
    IonicRadii(data::Vector{IonicRadius}) = new(
        data[1].atomic_number,
        sort!(data) )
end

IonicRadii(i::Vector{T}) where T <: Tuple = IonicRadii(IonicRadius.(i))

function Base.show(io::IO, irr::IonicRadii)
    print(io, irr.data)
end


Base.getindex(irr::IonicRadii, i::Integer) = irr.data[i]
Base.getindex(irr::IonicRadii, v::AbstractVector) = [irr[i] for i in v]