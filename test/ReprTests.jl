module ReprTests
using Mendeleev, Test
using Mendeleev: Group_M
using Mendeleev: ScreenConst

@testset "ReprTests" begin

O = chem_elements[8]
F = chem_elements[9]
K = chem_elements[:K]
Cu = chem_elements[:Cu]
Zr = chem_elements[:Zr]

# 2-argument show functions
@test repr([O, F]) == "ChemElem[Element(Oxygen), Element(Fluorine)]"

@test_broken repr("text/plain", chem_elements) == "Elements(…118 elements…):\nH                                                  He \nLi Be                               B  C  N  O  F  Ne \nNa Mg                               Al Si P  S  Cl Ar \nK  Ca Sc Ti V  Cr Mn Fe Co Ni Cu Zn Ga Ge As Se Br Kr \nRb Sr Y  Zr Nb Mo Tc Ru Rh Pd Ag Cd In Sn Sb Te I  Xe \nCs Ba    Hf Ta W  Re Os Ir Pt Au Hg Tl Pb Bi Po At Rn \nFr Ra    Rf Db Sg Bh Hs Mt Ds Rg Cn Nh Fl Mc Lv Ts Og \n                 \n      La Ce Pr Nd Pm Sm Eu Gd Tb Dy Ho Er Tm Yb Lu    \n      Ac Th Pa U  Np Pu Am Cm Bk Cf Es Fm Md No Lr    \n"
@test_broken repr("text/plain", O) == "Oxygen (O), number 8:\n        category: diatomic nonmetal\n     atomic mass: 15.999 u\n         density: 0.001429 g/cm³\n   melting point: 54.36 K\n   boiling point: 90.188 K\n           phase: Gas\n          shells: [2, 6]\ne⁻-configuration: 1s² 2s² 2p⁴\n         summary: Oxygen is a chemical element with symbol O and atomic number 8. It is a member of the chalcogen group on the periodic table and is a highly reactive nonmetal and oxidizing agent that readily forms compounds (notably oxides) with most chem_elements. By mass, oxygen is the third-most abundant element in the universe, after hydrogen and helium.\n   discovered by: Carl Wilhelm Scheele\n        named by: Antoine Lavoisier\n          source: https://en.wikipedia.org/wiki/Oxygen\n  spectral image: https://en.wikipedia.org/wiki/File:Oxygen_spectre.jpg\n"
@test_broken repr("text/html", O) == "<style>\nth{text-align:right; padding:5px;}td{text-align:left; padding:5px}\n</style>\nOxygen (O), number 8:\n<table>\n<tr><th>category</th><td>diatomic nonmetal</td></tr>\n<tr><th>atomic mass</th><td>15.999 u</td></tr>\n<tr><th>density</th><td>0.001429 g/cm³</td></tr>\n<tr><th>melting point</th><td>54.36 K</td></tr>\n<tr><th>boiling point</th><td>90.188 K</td></tr>\n<tr><th>phase</th><td>Gas</td></tr>\n<tr><th>shells</th><td>[2, 6]</td></tr>\n<tr><th>electron configuration</th><td>1s² 2s² 2p⁴</td></tr>\n<tr><th>summary</th><td>Oxygen is a chemical element with symbol O and atomic number 8. It is a member of the chalcogen group on the periodic table and is a highly reactive nonmetal and oxidizing agent that readily forms compounds (notably oxides) with most chem_elements. By mass, oxygen is the third-most abundant element in the universe, after hydrogen and helium.</td></tr>\n<tr><th>discovered by</th><td>Carl Wilhelm Scheele</td></tr>\n<tr><th>named by</th><td>Antoine Lavoisier</td></tr>\n<tr><th>source</th><td><a href=\"https://en.wikipedia.org/wiki/Oxygen\">https://en.wikipedia.org/wiki/Oxygen</a></td></tr>\n</table>\n<img src=\"https://commons.wikimedia.org/w/index.php?title=Special:Redirect/file/Oxygen_spectre.jpg&width=500\" alt=\"Oxygen_spectre.jpg\">\n"


@test repr(Cu.group) == "11[IB] (Coinage metals)"
@test repr(Zr.group) == "4[IVB]"

@test repr(K.sconst["2p"]) == "K 2p: 3.9728"
# @test repr(K.sconst) == "ScreenConst[K 1s: 0.5105, K 2s: 5.9938, K 2p: 3.9728, K 3s: 10.3201, K 3p: 11.2744, K 4s: 15.5048]"
@test repr(K.sconst) == "Mendeleev.ScreenConst[K 1s: 0.5105, K 2s: 5.9938, K 2p: 3.9728, K 3s: 10.3201, K 3p: 11.2744, K 4s: 15.5048]"

end #@testset "ReprTests"
end # ReprTests