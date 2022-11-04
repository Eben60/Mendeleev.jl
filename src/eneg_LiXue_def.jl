"""
    LiXueDSet
This struct describes electronegativity by Li-Xue scale for a given ionic states of an element.
It is not exported.
```
    atomic_number::Int
    charge::Int
    coordination::Symbol
    spin::Union{Symbol, Missing}
    value::Float64 # dimensionality to be clarified yet
```
"""
struct LiXueDSet
    atomic_number::Int
    charge::Int
    coordination::Symbol
    spin::Union{Symbol, Missing}
    value::Float64 # typeof(1.0*u"1/pm")
end

LiXueDSet(atomic_number, charge, coordination, spin, value::Real) =
    LiXueDSet(atomic_number, charge, coordination, spin, value*u"1/pm")

LiXueDSet(atomic_number, charge, t::Tuple) = LiXueDSet(atomic_number, charge, t...)

Base.show(io::IO, lx::LiXueDSet) = showpresent(io::IO, lx, [:coordination, :spin, :value])

function Base.isless(lx1::LiXueDSet, lx2::LiXueDSet)
    lx1.atomic_number != lx2.atomic_number && throw(DomainError("cannot compare Li-Xue electronegativities for different elements"))
    return (lx1.charge, lx1.coordination, lx1.spin) < (lx2.charge, lx2.coordination, lx2.spin)
end


"""
    LiXue
This struct is a container for Li-Xue scale electronegativities of different ionic states of an element.
It provides access by position(s) in the array of LiXueDSet structs for the given element,
as well as filtering according to
`(; charge, coordination, spin)`.
It is not exported.
# Examples
```julia-repl
julia> felx = chem_elements.Fe.eneg.Li;

julia> felx[2]
(Fe2+, coordination=IVSQ, spin=HS, value=4.826 pm⁻¹)

julia> felx[[2,3]]
2-element Vector{Mendeleev.LiXueDSet}:
 (Fe2+, coordination=IVSQ, spin=HS, value=4.826 pm⁻¹)
 (Fe2+, coordination=VI, spin=HS, value=4.092 pm⁻¹)

 julia> felx(;charge=2, spin=:HS) # filtering
 4-element Vector{Mendeleev.LiXueDSet}:
  (Fe2+, coordination=IV, spin=HS, value=4.889 pm⁻¹)
  (Fe2+, coordination=IVSQ, spin=HS, value=4.826 pm⁻¹)
  (Fe2+, coordination=VI, spin=HS, value=4.092 pm⁻¹)
  (Fe2+, coordination=VIII, spin=HS, value=3.551 pm⁻¹))

  julia> felx(;charge=2, spin=:HS, coordination=:VI) # filtering
  1-element Vector{Mendeleev.LiXueDSet}:
   (Fe2+, coordination=VI, spin=HS, value=4.092 pm⁻¹)
```
"""
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
    sort!(data)
    return LiXue(data)
end

lx_or_missing(atomic_number::Integer) =
    ismissing(lixue_data[atomic_number]) ? missing : LiXue(lixue_data[atomic_number], atomic_number)


(lx::LiXue)(; charge=nothing, coordination=nothing, spin=nothing) =
    [x for x in lx.data if fs_eq_or_nothing(x; charge, coordination, spin)]

Base.eachindex(lx::LiXue) = eachindex(lx.data)
Base.getindex(lx::LiXue, i::Integer) = lx.data[i]
Base.getindex(lx::LiXue, v::AbstractVector) = [lx[i] for i in v]


# support iterating over LiXue
Base.eltype(lx::LiXue) = LiXueDSet
Base.length(lx::LiXue) = length(lx.data)
Base.iterate(lx::LiXue, state...) = iterate(lx.data, state...)
