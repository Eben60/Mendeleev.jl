module SC
using Mendeleev, Test

const orb_typenums = Dict('s' => 1,
                           'p' => 2,
                           'd' => 3,
                           'f' => 4)

const orb_typenames = Dict([v=>k for (k, v) in zip(keys(orb_typenums), values(orb_typenums))])

struct ScreenConst
    atomic_number::Int
    orb_type::Int
    shell::Int
    val::Float64
end

ScreenConst(a, ss::AbstractChar, s, v) = ScreenConst(a, orb_typenums[ss], s, v)
ScreenConst(a, ss::T, s, v) where T <: Union{AbstractString, Symbol} = ScreenConst(a, orb_typenums[String(ss)[1]], s, v)


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
function find_sc(s::ScreenConstants, orb_type, shell::Int)
    sc0 = ScreenConst(s.atomic_number, orb_type, shell, NaN) # make dummy
    pos = searchsorted(s.data, sc0)
    isempty(pos) && return (; sc = nothing, sc0)
    return (; sc = s.data[pos[begin]], sc0)
end

function Base.getindex(s::ScreenConstants, orb_type, shell::Int)
    sc = find_sc(s, orb_type, shell)
    isnothing(sc.sc) && throw(KeyError("$(sc.sc0.shell)$(orb_typenames[sc.sc0.orb_type])"))
    return sc.sc
end


################
# tests

Fes1 = ScreenConst(26, 's', 1, 4)
Fes2 = ScreenConst(26, 's', 2, 4)
Fep1 = ScreenConst(26, 'p', 1, 4)
Ni = ScreenConst(28, 's', 1, 4)

scs = ScreenConstants([Fes1, Fes2, Fep1])

@test_throws DomainError ScreenConstants([Fes1, Fes2, Fep1, Ni])
@test_throws DomainError Fes1 < Ni
@test_throws KeyError scs[1,5]

@test Fes1 < Fes2
@test Fes1 < Fep1
@test !(Fep1 < Fes1)
@test SC.scs[1,1] == ScreenConst(26, 1,1, 4.0)

# # # #
end
