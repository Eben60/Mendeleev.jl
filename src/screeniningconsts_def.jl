module SC
using Mendeleev, Test

const orb_typenums = Dict('s' => 1,
                           'p' => 2,
                           'd' => 3,
                           'f' => 4)

const orb_typenames = Dict([v=>k for (k, v) in zip(keys(orb_typenums), values(orb_typenums))])

struct ScreenConst
    atomic_number::Int
    shell::Int
    orb_type::Int
    val::Float64
end

ScreenConst(a, s, ss::AbstractChar, v) = ScreenConst(a, s, orb_typenums[ss], v)
ScreenConst(a, s, ss::T, v) where T <: Union{AbstractString, Symbol} = ScreenConst(a, s, orb_typenums[String(ss)[1]], v)


function Base.show(io::IO, sc::ScreenConst)
    elem = ELEMENTS_M[sc.atomic_number].symbol
    orb_type = orb_typenames[sc.orb_type]
    orbital = "$(sc.shell)$orb_type"
    show("$elem $orbital: $(sc.val)")
end

function Base.isless(sc1::ScreenConst, sc2::ScreenConst)
    sc1.atomic_number != sc2.atomic_number && throw(DomainError("cannot compare ScreenConst for different elements"))
    sc1.shell != sc2.shell && return sc1.shell < sc2.shell
    return sc1.orb_type < sc2.orb_type
end

####

struct ScreenConstants
    atomic_number::Int
    data::Vector{ScreenConst}
    ScreenConstants(data::Vector{ScreenConst}) = new(
        data[1].atomic_number,
        sort!(data) )
end

function Base.show(io::IO, scs::ScreenConstants)
    show(scs.data)
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

################
# tests

Fes1 = ScreenConst(26, 1, 's', 4)
Fes2 = ScreenConst(26, 2, 's', 4)
Fep1 = ScreenConst(26, 1, 'p', 4)
Ni = ScreenConst(28, 1, 's', 4)

scs = ScreenConstants([Fes1, Fes2, Fep1])

@test_throws DomainError ScreenConstants([Fes1, Fes2, Fep1, Ni])
@test_throws DomainError Fes1 < Ni
@test_throws KeyError scs[1,5]

@test Fes1 < Fes2
@test Fes1 < Fep1
@test !(Fep1 < Fes1)
@test scs[2,1] == ScreenConst(26, 2,1, 4.0)
@test scs[2,1] == scs["2s"]
# # # #
end
