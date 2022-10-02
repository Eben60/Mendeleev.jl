module GeneralTests
using Mendeleev, Test

@test eltype(ELEMENTS_M) == Element_M
@test length(ELEMENTS_M) == 118 == length(collect(ELEMENTS_M))

O = ELEMENTS_M[8]
F = ELEMENTS_M[9]

# test element lookup
@test O != ELEMENTS_M[:F]
@test O === ELEMENTS_M["oxygen"] == ELEMENTS_M[:O]
@test haskey(ELEMENTS_M, 8) && haskey(ELEMENTS_M, "oxygen") && haskey(ELEMENTS_M, :O)
@test !haskey(ELEMENTS_M, -8) && !haskey(ELEMENTS_M, "ooxygen") && !haskey(ELEMENTS_M, :Oops)
@test_broken F === get(ELEMENTS_M, 9, O) === get(ELEMENTS_M, "oops", F) === get(ELEMENTS_M, :F, O)
@test ELEMENTS_M[8:9] == [O, F]
@test O.name == "Oxygen"
@test O.symbol == :O
@test nfields(O) == 3

# cpk colors
@test O.cpk_hex == "#f00000" # deviates from PeriodicTable.jl
@test F.cpk_hex == "#daa520" # deviates from PeriodicTable.jl
                             # but in agreement with e.g. https://www.umass.edu/microbio/chime/pe_beta/pe/shared/cpk-rgb.htm

# iteration protocol
@test iterate(ELEMENTS_M) == (ELEMENTS_M[:H], 2)
@test iterate(ELEMENTS_M, 4) == (ELEMENTS_M[:Be], 5)
@test iterate(ELEMENTS_M, length(ELEMENTS_M)+1) === nothing

# 2-argument show functions
@test repr([O, F]) == "Element_M[Element(Oxygen), Element(Fluorine)]"

@test_throws ErrorException O.name = "Issue21"
@test O.name == "Oxygen"

@test isless(ELEMENTS_M[28], ELEMENTS_M[29])
@test !isless(ELEMENTS_M[88], ELEMENTS_M[88])
@test !isless(ELEMENTS_M[92], ELEMENTS_M[90])
@test isequal(ELEMENTS_M[38], ELEMENTS_M[38])
@test !isequal(ELEMENTS_M[38], ELEMENTS_M[39])

@test ELEMENTS_M[28] < ELEMENTS_M[29]
@test ! (ELEMENTS_M[88] < ELEMENTS_M[88])
@test ! (ELEMENTS_M[92] < ELEMENTS_M[90])
@test ELEMENTS_M[92] > ELEMENTS_M[91]
@test !(ELEMENTS_M[92] > ELEMENTS_M[92])
@test !(ELEMENTS_M[92] > ELEMENTS_M[93])
@test ELEMENTS_M[90] <= ELEMENTS_M[91]
@test ELEMENTS_M[91] <= ELEMENTS_M[91]
@test !(ELEMENTS_M[92] <= ELEMENTS_M[91])
@test ELEMENTS_M[38] == ELEMENTS_M[38]
@test ELEMENTS_M[38] ≠ ELEMENTS_M[39]

# # Ensure that the hashcode works in Dict{}
# elmdict = Dict{Element_M,Int}( ELEMENTS_M[z] => z for z in eachindex(ELEMENTS_M))
# @test length(elmdict) == 118
# for z in eachindex(ELEMENTS_M)
#     @test haskey(elmdict, ELEMENTS_M[z])
#     @test elmdict[ELEMENTS_M[z]] == z
# end


@test_broken repr("text/plain", ELEMENTS_M) == "Elements(…118 elements…):\nH                                                  He \nLi Be                               B  C  N  O  F  Ne \nNa Mg                               Al Si P  S  Cl Ar \nK  Ca Sc Ti V  Cr Mn Fe Co Ni Cu Zn Ga Ge As Se Br Kr \nRb Sr Y  Zr Nb Mo Tc Ru Rh Pd Ag Cd In Sn Sb Te I  Xe \nCs Ba    Hf Ta W  Re Os Ir Pt Au Hg Tl Pb Bi Po At Rn \nFr Ra    Rf Db Sg Bh Hs Mt Ds Rg Cn Nh Fl Mc Lv Ts Og \n                 \n      La Ce Pr Nd Pm Sm Eu Gd Tb Dy Ho Er Tm Yb Lu    \n      Ac Th Pa U  Np Pu Am Cm Bk Cf Es Fm Md No Lr    \n"
@test_broken stringmime("text/plain", O) == "Oxygen (O), number 8:\n        category: diatomic nonmetal\n     atomic mass: 15.999 u\n         density: 0.001429 g/cm³\n   melting point: 54.36 K\n   boiling point: 90.188 K\n           phase: Gas\n          shells: [2, 6]\ne⁻-configuration: 1s² 2s² 2p⁴\n         summary: Oxygen is a chemical element with symbol O and atomic number 8. It is a member of the chalcogen group on the periodic table and is a highly reactive nonmetal and oxidizing agent that readily forms compounds (notably oxides) with most ELEMENTS_M. By mass, oxygen is the third-most abundant element in the universe, after hydrogen and helium.\n   discovered by: Carl Wilhelm Scheele\n        named by: Antoine Lavoisier\n          source: https://en.wikipedia.org/wiki/Oxygen\n  spectral image: https://en.wikipedia.org/wiki/File:Oxygen_spectre.jpg\n"
@test_broken stringmime("text/html", O) == "<style>\nth{text-align:right; padding:5px;}td{text-align:left; padding:5px}\n</style>\nOxygen (O), number 8:\n<table>\n<tr><th>category</th><td>diatomic nonmetal</td></tr>\n<tr><th>atomic mass</th><td>15.999 u</td></tr>\n<tr><th>density</th><td>0.001429 g/cm³</td></tr>\n<tr><th>melting point</th><td>54.36 K</td></tr>\n<tr><th>boiling point</th><td>90.188 K</td></tr>\n<tr><th>phase</th><td>Gas</td></tr>\n<tr><th>shells</th><td>[2, 6]</td></tr>\n<tr><th>electron configuration</th><td>1s² 2s² 2p⁴</td></tr>\n<tr><th>summary</th><td>Oxygen is a chemical element with symbol O and atomic number 8. It is a member of the chalcogen group on the periodic table and is a highly reactive nonmetal and oxidizing agent that readily forms compounds (notably oxides) with most ELEMENTS_M. By mass, oxygen is the third-most abundant element in the universe, after hydrogen and helium.</td></tr>\n<tr><th>discovered by</th><td>Carl Wilhelm Scheele</td></tr>\n<tr><th>named by</th><td>Antoine Lavoisier</td></tr>\n<tr><th>source</th><td><a href=\"https://en.wikipedia.org/wiki/Oxygen\">https://en.wikipedia.org/wiki/Oxygen</a></td></tr>\n</table>\n<img src=\"https://commons.wikimedia.org/w/index.php?title=Special:Redirect/file/Oxygen_spectre.jpg&width=500\" alt=\"Oxygen_spectre.jpg\">\n"

end
