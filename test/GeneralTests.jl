module GeneralTests
using Mendeleev, Test

@test eltype(ELEMENTS_M) == Element_M
@test length(ELEMENTS_M) == 118 == length(collect(ELEMENTS_M))

# test element lookup
O = ELEMENTS_M[8]
F = ELEMENTS_M[9]
@test O === ELEMENTS_M["oxygen"] == ELEMENTS_M[:O]
@test haskey(ELEMENTS_M, 8) && haskey(ELEMENTS_M, "oxygen") && haskey(ELEMENTS_M, :O)
@test !haskey(ELEMENTS_M, -8) && !haskey(ELEMENTS_M, "ooxygen") && !haskey(ELEMENTS_M, :Oops)
@test_broken F === get(ELEMENTS_M, 9, O) === get(ELEMENTS_M, "oops", F) === get(ELEMENTS_M, :F, O)
@test ELEMENTS_M[8:9] == [O, F]
@test O.name == "Oxygen"
@test O.symbol == :O
@test nfields(O) == 82

# cpk colors
@test O.cpk_hex == "#f00000" # deviates from PeriodicTable.jl
@test F.cpk_hex == "#daa520" # deviates from PeriodicTable.jl
                             # but in agreement with e.g. https://www.umass.edu/microbio/chime/pe_beta/pe/shared/cpk-rgb.htm
                             

end
