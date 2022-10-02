module GeneralTests
using Mendeleev, Test

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

# 2-argument show functions
@test repr([O, F]) == "ChemElem[Element(Oxygen), Element(Fluorine)]"

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
@test length(pns) == 95
@test :abundance_sea in pns # elements_data
@test :number in pns # synonym
@test :melt in pns # synonym for melting_point
@test :melting_point in pns # elements_data
@test :atomic_number in pns # struct field
@test :symbol in pns # struct field
@test :ionenergy in pns # fn_ionenergy from property_functions.jl

# # Ensure that the hashcode works in Dict{}
# elmdict = Dict{ChemElem,Int}( chem_elements[z] => z for z in eachindex(chem_elements))
# @test length(elmdict) == 118
# for z in eachindex(chem_elements)
#     @test haskey(elmdict, chem_elements[z])
#     @test elmdict[chem_elements[z]] == z
# end


@test_broken repr("text/plain", chem_elements) == "Elements(…118 elements…):\nH                                                  He \nLi Be                               B  C  N  O  F  Ne \nNa Mg                               Al Si P  S  Cl Ar \nK  Ca Sc Ti V  Cr Mn Fe Co Ni Cu Zn Ga Ge As Se Br Kr \nRb Sr Y  Zr Nb Mo Tc Ru Rh Pd Ag Cd In Sn Sb Te I  Xe \nCs Ba    Hf Ta W  Re Os Ir Pt Au Hg Tl Pb Bi Po At Rn \nFr Ra    Rf Db Sg Bh Hs Mt Ds Rg Cn Nh Fl Mc Lv Ts Og \n                 \n      La Ce Pr Nd Pm Sm Eu Gd Tb Dy Ho Er Tm Yb Lu    \n      Ac Th Pa U  Np Pu Am Cm Bk Cf Es Fm Md No Lr    \n"
@test_broken stringmime("text/plain", O) == "Oxygen (O), number 8:\n        category: diatomic nonmetal\n     atomic mass: 15.999 u\n         density: 0.001429 g/cm³\n   melting point: 54.36 K\n   boiling point: 90.188 K\n           phase: Gas\n          shells: [2, 6]\ne⁻-configuration: 1s² 2s² 2p⁴\n         summary: Oxygen is a chemical element with symbol O and atomic number 8. It is a member of the chalcogen group on the periodic table and is a highly reactive nonmetal and oxidizing agent that readily forms compounds (notably oxides) with most chem_elements. By mass, oxygen is the third-most abundant element in the universe, after hydrogen and helium.\n   discovered by: Carl Wilhelm Scheele\n        named by: Antoine Lavoisier\n          source: https://en.wikipedia.org/wiki/Oxygen\n  spectral image: https://en.wikipedia.org/wiki/File:Oxygen_spectre.jpg\n"
@test_broken stringmime("text/html", O) == "<style>\nth{text-align:right; padding:5px;}td{text-align:left; padding:5px}\n</style>\nOxygen (O), number 8:\n<table>\n<tr><th>category</th><td>diatomic nonmetal</td></tr>\n<tr><th>atomic mass</th><td>15.999 u</td></tr>\n<tr><th>density</th><td>0.001429 g/cm³</td></tr>\n<tr><th>melting point</th><td>54.36 K</td></tr>\n<tr><th>boiling point</th><td>90.188 K</td></tr>\n<tr><th>phase</th><td>Gas</td></tr>\n<tr><th>shells</th><td>[2, 6]</td></tr>\n<tr><th>electron configuration</th><td>1s² 2s² 2p⁴</td></tr>\n<tr><th>summary</th><td>Oxygen is a chemical element with symbol O and atomic number 8. It is a member of the chalcogen group on the periodic table and is a highly reactive nonmetal and oxidizing agent that readily forms compounds (notably oxides) with most chem_elements. By mass, oxygen is the third-most abundant element in the universe, after hydrogen and helium.</td></tr>\n<tr><th>discovered by</th><td>Carl Wilhelm Scheele</td></tr>\n<tr><th>named by</th><td>Antoine Lavoisier</td></tr>\n<tr><th>source</th><td><a href=\"https://en.wikipedia.org/wiki/Oxygen\">https://en.wikipedia.org/wiki/Oxygen</a></td></tr>\n</table>\n<img src=\"https://commons.wikimedia.org/w/index.php?title=Special:Redirect/file/Oxygen_spectre.jpg&width=500\" alt=\"Oxygen_spectre.jpg\">\n"

end
