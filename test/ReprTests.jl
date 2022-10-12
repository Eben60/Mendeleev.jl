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

# @test_broken repr("text/plain", chem_elements) == "Elements(…118 elements…):\nH                                                  He \nLi Be                               B  C  N  O  F  Ne \nNa Mg                               Al Si P  S  Cl Ar \nK  Ca Sc Ti V  Cr Mn Fe Co Ni Cu Zn Ga Ge As Se Br Kr \nRb Sr Y  Zr Nb Mo Tc Ru Rh Pd Ag Cd In Sn Sb Te I  Xe \nCs Ba    Hf Ta W  Re Os Ir Pt Au Hg Tl Pb Bi Po At Rn \nFr Ra    Rf Db Sg Bh Hs Mt Ds Rg Cn Nh Fl Mc Lv Ts Og \n                 \n      La Ce Pr Nd Pm Sm Eu Gd Tb Dy Ho Er Tm Yb Lu    \n      Ac Th Pa U  Np Pu Am Cm Bk Cf Es Fm Md No Lr    \n"

@test repr(Cu.group) == "11[IB] (Coinage metals)"
@test repr(Zr.group) == "4[IVB]"

@test repr(K.sconst["2p"]) == "K 2p: 3.9728"
# @test repr(K.sconst) == "ScreenConst[K 1s: 0.5105, K 2s: 5.9938, K 2p: 3.9728, K 3s: 10.3201, K 3p: 11.2744, K 4s: 15.5048]"
@test repr(K.sconst) == "Mendeleev.ScreenConst[K 1s: 0.5105, K 2s: 5.9938, K 2p: 3.9728, K 3s: 10.3201, K 3p: 11.2744, K 4s: 15.5048]"


repr_O = """Oxygen (O), number 8:
        category: diatomic nonmetal
     atomic mass: 15.999 u
natural isotopes: ((99.738% ¹⁶O m=15.99491462 u ), (0.04% ¹⁷O m=16.999131757 u ), (0.22200000000000003% ¹⁸O m=17.999159613 u ))
         density: 0.001308 g/cm³
 molar heat cap.: 29.378 J/mol⋅K
   melting point: 54.8 K
   boiling point: 90.19 K
           phase: Gas
          shells: [2, 6]
e⁻-configuration: 1s² 2s² 2p⁴
         summary: Oxygen is a chemical element with symbol O and atomic number 8. It is a member of the chalcogen group on the periodic table and is a highly reactive nonmetal and oxidizing agent that readily forms compounds (notably oxides) with most elements. By mass, oxygen is the third-most abundant element in the universe, after hydrogen and helium.
  CAS identifier: 7782-44-7
   discovered by: 1774 by Joseph Priestly, Carl Wilhelm Scheele in England/Sweden
    NIST webbook: https://webbook.nist.gov/cgi/inchi/InChI%3D1S/O2/c1-2
   wikipedia URL: https://en.wikipedia.org/wiki/Oxygen
  spectral image: https://en.wikipedia.org/wiki/File:Oxygen_spectre.jpg
"""
@test repr("text/plain", O) == repr_O


repr_O_html = 
"""<style>
th{text-align:right; padding:5px;}td{text-align:left; padding:5px}
</style>
Oxygen (O), number 8:
<table>
<tr><th>category</th><td>diatomic nonmetal</td></tr>
<tr><th>atomic mass</th><td>15.999 u</td></tr>
<tr><th>natural isotopes</th><td>((99.738% ¹⁶O m=15.99491462 u ), (0.04% ¹⁷O m=16.999131757 u ), (0.22200000000000003% ¹⁸O m=17.999159613 u ))</td></tr>
<tr><th>density</th><td>0.001308 g/cm³</td></tr>
<tr><th>molar heat cap.</th><td>29.378 J/mol⋅K</td></tr>
<tr><th>melting point</th><td>54.8 K</td></tr>
<tr><th>boiling point</th><td>90.19 K</td></tr>
<tr><th>phase</th><td>Gas</td></tr>
<tr><th>shells</th><td>[2, 6]</td></tr>
<tr><th>e⁻-configuration</th><td>1s² 2s² 2p⁴</td></tr>
<tr><th>summary</th><td>Oxygen is a chemical element with symbol O and atomic number 8. It is a member of the chalcogen group on the periodic table and is a highly reactive nonmetal and oxidizing agent that readily forms compounds (notably oxides) with most elements. By mass, oxygen is the third-most abundant element in the universe, after hydrogen and helium.</td></tr>
<tr><th>CAS identifier</th><td>7782-44-7</td></tr>
<tr><th>spectral image</th><td>https://en.wikipedia.org/wiki/File:Oxygen_spectre.jpg</td></tr>
<tr><th>discovered by</th><td>1774 by Joseph Priestly, Carl Wilhelm Scheele in England/Sweden</td></tr>
<tr><th>wikipedia</th><td><a href="https://en.wikipedia.org/wiki/Oxygen">https://en.wikipedia.org/wiki/Oxygen</a></td></tr>
<tr><th>NIST webbook</th><td><a href="https://webbook.nist.gov/cgi/inchi/InChI%3D1S/O2/c1-2">https://webbook.nist.gov/cgi/inchi/InChI%3D1S/O2/c1-2</a></td></tr>
</table>
<img src="https://commons.wikimedia.org/w/index.php?title=Special:Redirect/file/Oxygen_spectre.jpg&width=500" alt="Oxygen_spectre.jpg">
"""

@test repr("text/html", O) == repr_O_html

repr_els =
"""Elements(…118 elements…):
H                                                  He 
Li Be                               B  C  N  O  F  Ne 
Na Mg                               Al Si P  S  Cl Ar 
K  Ca Sc Ti V  Cr Mn Fe Co Ni Cu Zn Ga Ge As Se Br Kr 
Rb Sr Y  Zr Nb Mo Tc Ru Rh Pd Ag Cd In Sn Sb Te I  Xe 
Cs Ba    Hf Ta W  Re Os Ir Pt Au Hg Tl Pb Bi Po At Rn 
Fr Ra    Rf Db Sg Bh Hs Mt Ds Rg Cn Nh Fl Mc Lv Ts Og 
                                                      
      La Ce Pr Nd Pm Sm Eu Gd Tb Dy Ho Er Tm Yb Lu    
      Ac Th Pa U  Np Pu Am Cm Bk Cf Es Fm Md No Lr    
"""
@test repr("text/plain", chem_elements) == repr_els

end #@testset "ReprTests"
end # ReprTests