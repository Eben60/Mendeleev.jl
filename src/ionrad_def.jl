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
    ionic_potential::typeof(1.0u"e_au"/u"pm")
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
    ionic_potential::typeof(1.0u"e_au"/u"pm")
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

"""
    fs_eq_or_nothing(x; kwargs...)
The function checks if `x` satisfies conditions defined by those kwargs which are not `nothing` 
It is not exported.
"""
fs_eq_or_nothing(x; kwargs...) = 
    all([(isnothing(v) || (!ismissing(getfield(x, k)) && v == getfield(x, k))) for (k,v) in kwargs])


Base.show(io::IO, ir::IonicRadius) = showpresent(io::IO, ir, 
    [:coordination, :econf, :spin, :crystal_radius, :ionic_radius, :ionic_potential, :origin, :most_reliable])

function Base.isless(sc1::IonicRadius, sc2::IonicRadius)
    sc1.atomic_number != sc2.atomic_number && throw(DomainError("cannot compare IonicRadius for different elements"))
    return sc1.charge < sc2.charge
end

# IonicRadii equality is determined by atomic number and charge
Base.isequal(ir1::IonicRadius, ir2::IonicRadius) = (ir1.atomic_number, ir1.charge) == (ir2.atomic_number, ir2.charge)

struct IonicRadii
    data::Vector{IonicRadius}
    IonicRadii(data::Vector{IonicRadius}) = new(
        sort!(data) )
end

"""
    IonicRadii
This struct is a container for ionic radii of an element. It provides access by 
position(s) in the array of IonicRadius structs for the given element, 
as well as filtering according to 
`(; charge, coordination, spin, econf, most_reliable)`. 
It is not exported.
# Examples
```julia-repl
julia> feir = chem_elements.Fe.ionic_radii;

julia> feir[2]
(Fe2+, coordination=IVSQ, econf=3d6, spin=HS, crystal_radius=78.0 pm, ionic_radius=64.0 pm, ionic_potential=0.03125 e pm⁻¹, most_reliable=false)

julia> feir[[2,3]]
2-element Vector{Mendeleev.IonicRadius}:
 (Fe2+, coordination=IVSQ, econf=3d6, spin=HS, crystal_radius=78.0 pm, ionic_radius=64.0 pm, ionic_potential=0.03125 e pm⁻¹, most_reliable=false)
 (Fe2+, coordination=VI, econf=3d6, spin=LS, crystal_radius=75.0 pm, ionic_radius=61.0 pm, ionic_potential=0.03279 e pm⁻¹, origin=estimated, , most_reliable=false)

julia> feir(;most_reliable=true) # filtering
3-element Vector{Mendeleev.IonicRadius}:
 (Fe2+, coordination=VI, econf=3d6, spin=HS, crystal_radius=92.0 pm, ionic_radius=78.0 pm, ionic_potential=0.02564 e pm⁻¹, origin=from r^3 vs V plots, , most_reliable=true)
 (Fe3+, coordination=IV, econf=3d5, spin=HS, crystal_radius=63.0 pm, ionic_radius=49.0 pm, ionic_potential=0.06122 e pm⁻¹, most_reliable=true)
 (Fe3+, coordination=VI, econf=3d5, spin=HS, crystal_radius=78.5 pm, ionic_radius=64.5 pm, ionic_potential=0.04651 e pm⁻¹, origin=from r^3 vs V plots, , most_reliable=true)
 
julia> feir(;charge=2, coordination=:VI, econf="3d6", spin=:HS, most_reliable=true) #filtering
1-element Vector{Mendeleev.IonicRadius}:
 (Fe2+, coordination=VI, econf=3d6, spin=HS, crystal_radius=92.0 pm, ionic_radius=78.0 pm, ionic_potential=0.02564 e pm⁻¹, origin=from r^3 vs V plots, , most_reliable=true)
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


# support iterating over IonicRadii
Base.eltype(irs::IonicRadii) = IonicRadius
Base.length(irs::IonicRadii) = length(irs.data)
Base.iterate(irs::IonicRadii, state...) = iterate(irs.data, state...)

(irs::IonicRadii)(; charge=nothing, coordination=nothing, spin=nothing, econf=nothing, most_reliable=nothing) = 
    [x for x in irs.data if fs_eq_or_nothing(x; charge, coordination, spin, econf, most_reliable)]
