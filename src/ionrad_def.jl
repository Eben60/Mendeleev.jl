const e_charge = Unitful.q # elementary charge 

"""
    IonicRadius
This struct describes ionic radius for a given charge state of a given element. 
It is not exported.
```
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

function sigchar(x)
    x > 0 && return "+"
    x < 0 && return "-"
    x == 0 && return ""
end

function stringpresent(x, field::Symbol)
    f = getfield(x, field)
    ismissing(f) && return ""
    f isa Union{String, Symbol, Bool} && return "$field=$f"
    f_uless = f |> ustrip
    f = round(f_uless; sigdigits = 4)*oneunit(f)
    return "$field=$f"
end

"""
    ionsymb(x)
The function retuns a string with the ion symbol like `Cl5+`. Used also for Li-Xue electronegativities representation.
It is not exported.
"""
ionsymb(x) = (chem_elements[x.atomic_number].symbol |> string) * "$(abs(x.charge))" * sigchar(x.charge)

"""
    showpresent(io::IO, x, fnames)
The function prints ion-related struct. Used also for Li-Xue electronegativities representation.
It is not exported.
"""
function showpresent(io::IO, x, fnames)
    parts = [stringpresent(x, f) for f in fnames]
    filter!(x -> x != "", parts)
    parts = join(vcat(ionsymb(x), parts), ", ")
    print(io, "($parts)")
    return nothing
end

Base.show(io::IO, ir::IonicRadius) = showpresent(io::IO, ir, [:coordination, :econf, :spin, :crystal_radius, :ionic_radius, :ionic_potential, :origin, :most_reliable])


# function Base.show(io::IO, ir::IonicRadius)
#     fnames = [:coordination, :econf, :spin, :crystal_radius, :ionic_radius, :ionic_potential, :origin, :most_reliable]
#     parts = [stringpresent(ir, f) for f in fnames]
#     filter!(x -> x != "", parts)
#     parts = join(vcat(ionsymb(ir), parts), ", ")
#     print(io, "($parts)")
#     return nothing
# end

function Base.isless(sc1::IonicRadius, sc2::IonicRadius)
    sc1.atomic_number != sc2.atomic_number && throw(DomainError("cannot compare IonicRadius for different elements"))
    return sc1.charge < sc2.charge
end

# IonicRadii equality is determined by atomic number and charge
Base.isequal(ir1::IonicRadius, ir2::IonicRadius) = (ir1.atomic_number, ir1.charge) == (ir2.atomic_number, ir2.charge)

struct IonicRadii
    # atomic_number::Int
    data::Vector{IonicRadius}
    IonicRadii(data::Vector{IonicRadius}) = new(
        # data[1].atomic_number,
        sort!(data) )
end

"""
    IonicRadii
This struct is a container for ionic radii of an element. It provides access only by 
position(s) in the array of IonicRadius structs for the given element.
It is not exported.
# Examples
```julia-repl
julia> chem_elements[:Cl].ionic_radii[2]
(Cl5+, coordination=IIIPY, econf=3s2, crystal_radius=26.0 pm, ionic_radius=12.0 pm, ionic_potential=6.676e-8 C m⁻¹, most_reliable=false)

julia> chem_elements[:Cl].ionic_radii[[2,3]]
2-element Vector{Mendeleev.IonicRadius}:
 (Cl5+, coordination=IIIPY, econf=3s2, crystal_radius=26.0 pm, ionic_radius=12.0 pm, ionic_potential=6.676e-8 C m⁻¹, most_reliable=false)
 (Cl7+, coordination=IV, econf=2p6, crystal_radius=22.0 pm, ionic_radius=8.0 pm, ionic_potential=1.402e-7 C m⁻¹, most_reliable=true)
``` 
""" 
function IonicRadii(atomic_number::Integer)
    range = ionrad_ranges[atomic_number]
    ismissing(range) && return missing
    range = range[begin] : range[end]
    radii = [IonicRadius(atomic_number, r) for r in range]  
    return IonicRadii(radii)
end

IonicRadii(e::ChemElem) = IonicRadii(e.atomic_number)

function Base.show(io::IO, irs::IonicRadii)
    nm = chem_elements[irs[1].atomic_number].name 
    println(io, "ionic radii for $nm")
    for ir in irs
        println(io, ir)
    end
end

Base.eachindex(irs::IonicRadii) = eachindex(irs.data)
Base.getindex(irs::IonicRadii, i::Integer) = irs.data[i]
Base.getindex(irs::IonicRadii, v::AbstractVector) = [irs[i] for i in v]

# Base.get(irs::IonicRadii, i::Integer, default) = get(irs.data[i], i, default)

# support iterating over IonicRadii
Base.eltype(irs::IonicRadii) = IonicRadius
Base.length(irs::IonicRadii) = length(irs.data)
Base.iterate(irs::IonicRadii, state...) = iterate(irs.data, state...)

