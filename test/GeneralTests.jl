module GeneralTests
using Mendeleev, Test, Unitful

@testset "GeneralTests" begin

@test eltype(chem_elements) == ChemElem
@test length(chem_elements) == 118 == length(collect(chem_elements))

O = chem_elements[8]
F = chem_elements[9]

# test element lookup
@test O != chem_elements[:F]
@test O === chem_elements["oxygen"] == chem_elements[:O]
@test haskey(chem_elements, 8) && haskey(chem_elements, "oxygen") && haskey(chem_elements, :O)
@test !haskey(chem_elements, -8) && !haskey(chem_elements, "ooxygen") && !haskey(chem_elements, :Oops)

# TODO or not TODO
# actually I don't see any need for get with default value
# @test_broken F === get(chem_elements, 9, O) === get(chem_elements, "oops", F) === get(chem_elements, :F, O)
@test chem_elements[8:9] == [O, F]
@test O.name == "Oxygen"
@test O.symbol == :O
@test nfields(O) == 3

# cpk colors
@test O.cpk_hex == "#f00000" # deviates from PeriodicTable.jl
@test F.cpk_hex == "#daa520" # deviates from PeriodicTable.jl
                             # but in agreement with e.g. https://www.umass.edu/microbio/chime/pe_beta/pe/shared/cpk-rgb.htm

# iteration protocol
@test iterate(chem_elements) == (chem_elements[:H], 2)
@test iterate(chem_elements, 4) == (chem_elements[:Be], 5)
@test iterate(chem_elements, length(chem_elements)+1) === nothing


@test_throws ErrorException O.name = "Issue21"
@test O.name == "Oxygen"

@test isless(chem_elements[28], chem_elements[29])
@test !isless(chem_elements[88], chem_elements[88])
@test !isless(chem_elements[92], chem_elements[90])
@test isequal(chem_elements[38], chem_elements[38])
@test !isequal(chem_elements[38], chem_elements[39])

@test chem_elements[28] < chem_elements[29]
@test ! (chem_elements[88] < chem_elements[88])
@test ! (chem_elements[92] < chem_elements[90])
@test chem_elements[92] > chem_elements[91]
@test !(chem_elements[92] > chem_elements[92])
@test !(chem_elements[92] > chem_elements[93])
@test chem_elements[90] <= chem_elements[91]
@test chem_elements[91] <= chem_elements[91]
@test !(chem_elements[92] <= chem_elements[91])
@test chem_elements[38] == chem_elements[38]
@test chem_elements[38] ≠ chem_elements[39]

pns = propertynames(F)
@test length(pns) == 101
@test :abundance_sea in pns # elements_data
@test :number in pns # synonym
@test :melt in pns # synonym for melting_point
@test :melting_point in pns # elements_data
@test :atomic_number in pns # struct field
@test :symbol in pns # struct field
@test :ionenergy in pns # fn_ionenergy from property_functions.jl
@test Mendeleev.property_fns[:series] == Mendeleev.fn_series

# Ensure that the hashcode works in Dict{}
elmdict = Dict{ChemElem,Int}( chem_elements[z] => z for z in eachindex(chem_elements))
@test length(elmdict) == 118

@test begin 
    t = true
    for z in eachindex(chem_elements)
        if !(haskey(elmdict, chem_elements[z]) && (elmdict[chem_elements[z]] == z))
            t = false
            break
        end
    end
    t
end

Eth = Mendeleev.ChemElem(0, "Ether", :Eth)
@test Eth.symbol == :Eth

Eths = Mendeleev.ChemElems([Eth])
@test Eths[:Eth] == Eth
@test Eths["Ether"] == Eth

end # @testset
end
