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

"""
Depending on some unknown to me factors, Mendeleev types sometimes are shown with `Mendeleev` prefix, sometimes not.
Thus we add it anyway before doing test
"""
mend_repr(x) = startswith(x, "Mendeleev.") ? x : "Mendeleev." * x

# 2-argument show functions
@test mend_repr(repr([O, F])) == "Mendeleev.ChemElem[Element(Oxygen), Element(Fluorine)]"

@test repr(Cu.group) == "11[IB] (Coinage metals)"
@test repr(Zr.group) == "4[IVB]"

@test repr(K.sconst["2p"]) == "K 2p: 3.9728"

@test mend_repr(repr(K.sconst)) == "Mendeleev.ScreenConst[K 1s: 0.5105, K 2s: 5.9938, K 2p: 3.9728, K 3s: 10.3201, K 3p: 11.2744, K 4s: 15.5048]"

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
@test repr("text/plain", O) == repr_O # OK


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

@test repr("text/html", O) == repr_O_html # ok

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

Cl = chem_elements[:Cl]
repr_ionrad_mac =
"""ionic radii for Chlorine
(Cl1-, coordination=VI, econf=3p6, crystal_radius=167.0 pm, ionic_radius=181.0 pm, ionic_potential=-0.005525 e pm⁻¹, origin=Pauling's (1960) crystal radius, , most_reliable=false)
(Cl5+, coordination=IIIPY, econf=3s2, crystal_radius=26.0 pm, ionic_radius=12.0 pm, ionic_potential=0.4167 e pm⁻¹, most_reliable=false)
(Cl7+, coordination=IV, econf=2p6, crystal_radius=22.0 pm, ionic_radius=8.0 pm, ionic_potential=0.875 e pm⁻¹, most_reliable=true)
(Cl7+, coordination=VI, econf=2p6, crystal_radius=41.0 pm, ionic_radius=27.0 pm, ionic_potential=0.2593 e pm⁻¹, origin=Ahrens (1952) ionic radius, , most_reliable=false)
"""

repr_ionrad_win =
"""ionic radii for Chlorine
(Cl1-, coordination=VI, econf=3p6, crystal_radius=167.0 pm, ionic_radius=181.0 pm, ionic_potential=-0.005525 e pm^-1, origin=Pauling's (1960) crystal radius, , most_reliable=false)
(Cl5+, coordination=IIIPY, econf=3s2, crystal_radius=26.0 pm, ionic_radius=12.0 pm, ionic_potential=0.4167 e pm^-1, most_reliable=false)
(Cl7+, coordination=IV, econf=2p6, crystal_radius=22.0 pm, ionic_radius=8.0 pm, ionic_potential=0.875 e pm^-1, most_reliable=true)
(Cl7+, coordination=VI, econf=2p6, crystal_radius=41.0 pm, ionic_radius=27.0 pm, ionic_potential=0.2593 e pm^-1, origin=Ahrens (1952) ionic radius, , most_reliable=false)
"""

@test repr("text/plain", Cl.ionic_radii) in [repr_ionrad_mac, repr_ionrad_win]

cleneg = Cl.eneg
repr_eneg_mac =
"""Electronegativities for Cl
    atomic_number=17
    Allen=16.97 eV
    Allred=0.0006223854708703193 e² pm⁻²
    Cottrell=0.2482260292881502 e¹ᐟ² pm⁻¹ᐟ²
    Ghosh=0.263803 pm⁻¹
    Gordy=0.06161616161616161 e pm⁻¹
    Martynov=7.640517652620142 eV¹ᐟ²
    Mulliken=6.483815 eV
    Nagle=0.7826754796597776 Å⁻¹
    Pauling=3.16 eV¹ᐟ²
    Sanderson=0.81237728291421
Li-Xue Electronegativities for Cl
    (Cl5+, coordination=IIIPY, value=24.79 pm⁻¹)
    (Cl7+, coordination=IV, value=38.06 pm⁻¹)
    (Cl7+, coordination=VI, value=20.42 pm⁻¹)
"""

repr_eneg_win = 
"""Electronegativities for Cl
    atomic_number=17
    Allen=16.97 eV
    Allred=0.0006223854708703193 e^2 pm^-2
    Cottrell=0.2482260292881502 e^1/2 pm^-1/2
    Ghosh=0.263803 pm^-1
    Gordy=0.06161616161616161 e pm^-1
    Martynov=7.640517652620142 eV^1/2
    Mulliken=6.483815 eV
    Nagle=0.7826754796597776 Å^-1
    Pauling=3.16 eV^1/2
    Sanderson=0.81237728291421
Li-Xue Electronegativities for Cl
    (Cl5+, coordination=IIIPY, value=24.79 pm^-1)
    (Cl7+, coordination=IV, value=38.06 pm^-1)
    (Cl7+, coordination=VI, value=20.42 pm^-1)
"""

@test repr("text/plain", cleneg) in [repr_eneg_mac, repr_eneg_win]

"""
julia> fl = "ener-repr_mac.txt";
julia> open(fl, "w") do io
        show(io, cleneg)
        end
"""

end #@testset "ReprTests"
end # ReprTests