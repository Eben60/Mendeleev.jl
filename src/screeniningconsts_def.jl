const orb_typenums = Dict('s' => 1,
                           'p' => 2,
                           'd' => 3,
                           'f' => 4)

const orb_typenames = Dict([v=>k for (k, v) in zip(keys(orb_typenums), values(orb_typenums))])


"""
    ScreenConst
This struct describes screening constant for a given orbital of a given element. 
It is not exported.
```
    atomic_number::Int
    shell::Int
    orb_type::Int
    screening::Float64
```    
"""
struct ScreenConst
    atomic_number::Int
    shell::Int
    orb_type::Int
    screening::Float64
end


ScreenConst(a, s, ss::AbstractChar, v) = ScreenConst(a, s, orb_typenums[ss], v)
ScreenConst(a, s, ss::T, v) where T <: Union{AbstractString, Symbol} = ScreenConst(a, s, orb_typenums[String(ss)[1]], v)
ScreenConst(t::T) where T <: Tuple = ScreenConst(t...)

function Base.show(io::IO, sc::ScreenConst)
    elem = chem_elements[sc.atomic_number].symbol
    orb_type = orb_typenames[sc.orb_type]
    orbital = "$(sc.shell)$orb_type"
    print(io, "$elem $orbital: $(sc.screening)")
end

function Base.isless(sc1::ScreenConst, sc2::ScreenConst)
    sc1.atomic_number != sc2.atomic_number && throw(DomainError("cannot compare ScreenConst for different elements"))
    sc1.shell != sc2.shell && return sc1.shell < sc2.shell
    return sc1.orb_type < sc2.orb_type
end

"""
    ScreenConstants
This struct is a container for screening constants of an element. See examples below for indexing access. 
It is not exported.

# Examples
```julia-repl
julia> chem_elements[:Mo].sconst[2, 1]
Mo 2s: 11.1232

julia> chem_elements[:Mo].sconst[2, 's']
Mo 2s: 11.1232

julia> chem_elements[:Mo].sconst[2, "s"]
Mo 2s: 11.1232

julia> chem_elements[:Mo].sconst["2s"]
Mo 2s: 11.1232
```

"""  
struct ScreenConstants
    atomic_number::Int
    data::Vector{ScreenConst}
    ScreenConstants(data::Vector{ScreenConst}) = new(
        data[1].atomic_number,
        sort!(data) )
end

ScreenConstants(s::Vector{T}) where T <: Tuple = ScreenConstants(ScreenConst.(s))

function Base.show(io::IO, scs::ScreenConstants)
    print(io, scs.data)
end

# like getindex, but don't throw error
function find_sc(s::ScreenConstants, shell::Int, orb_type)
    sc0 = ScreenConst(s.atomic_number, shell, orb_type, NaN) # make dummy
    pos = searchsorted(s.data, sc0)
    isempty(pos) && return (; sc = nothing, sc0)
    return (; sc = s.data[pos[begin]], sc0)
end

function find_sc(s::ScreenConstants, orbital::AbstractString)
    shell = parse(Int, orbital[begin:end-1])
    orb_type = orbital[end]
    return find_sc(s, shell, orb_type)
end

function Base.getindex(s::ScreenConstants, shell::Int, orb_type)
    sc = find_sc(s, shell, orb_type)
    isnothing(sc.sc) && throw(KeyError("$(sc.sc0.shell)$(orb_typenames[sc.sc0.orb_type])"))
    return sc.sc
end

function Base.getindex(s::ScreenConstants, orbital::AbstractString)
    sc = find_sc(s, orbital)
    isnothing(sc.sc) && throw(KeyError("$(sc.sc0.shell)$(orb_typenames[sc.sc0.orb_type])"))
    return sc.sc
end
