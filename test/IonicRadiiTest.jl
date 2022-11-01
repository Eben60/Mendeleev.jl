module IonicRadiiTests
using Mendeleev, Test, Unitful
using Mendeleev: IonicRadius, IonicRadii # , ChemElem

@testset "IonicRadiiTests" begin

Cl = chem_elements[:Cl]
Cl1minus= Cl.ionic_radii[1]
Cl5plus = Cl.ionic_radii[2]
Fe = chem_elements[:Fe]
feir = Fe.ionic_radii

@test Cl1minus.charge == -1
@test Cl5plus.charge == 5

@test Cl5plus.coordination == :IIIPY
@test Cl5plus.econf == "3s2"
@test Cl5plus.crystal_radius == 26.0u"pm"
@test Cl5plus.ionic_radius == 12.0u"pm"
@test ! Cl5plus.most_reliable
@test Cl1minus.origin == "Pauling's (1960) crystal radius, "
@test ismissing(Cl5plus.origin)
@test Cl5plus.ionic_potential ≈ 6.675735975e-8u"C/m"

NotAnEl_IR = IonicRadius(1, 3, :III, 25.0u"pm", "0s7", 25.5u"pm", false, missing, :HS, 1.1u"C/m")

@test_throws DomainError Cl1minus < NotAnEl_IR
@test  Cl1minus != NotAnEl_IR
@test Cl1minus < Cl5plus

@test eltype(Cl.ionic_radii) == typeof(NotAnEl_IR)
@test length(Cl.ionic_radii) == 4
@test Cl.ionic_radii[[2, 4]] == [Cl.ionic_radii[2], Cl.ionic_radii[4]]

"""
1  (Fe2+, coordination=IV, econf=3d6, spin=HS, crystal_radius=77.0 pm, ionic_radius=63.0 pm, ionic_potential=5.086e-9 C m⁻¹, most_reliable=false)
2  (Fe2+, coordination=IVSQ, econf=3d6, spin=HS, crystal_radius=78.0 pm, ionic_radius=64.0 pm, ionic_potential=5.007e-9 C m⁻¹, most_reliable=false)
3  (Fe2+, coordination=VI, econf=3d6, spin=LS, crystal_radius=75.0 pm, ionic_radius=61.0 pm, ionic_potential=5.253e-9 C m⁻¹, origin=estimated, , most_reliable=false)
4  (Fe2+, coordination=VI, econf=3d6, spin=HS, crystal_radius=92.0 pm, ionic_radius=78.0 pm, ionic_potential=4.108e-9 C m⁻¹, origin=from r^3 vs V plots, , most_reliable=true)
5  (Fe2+, coordination=VIII, econf=3d6, spin=HS, crystal_radius=106.0 pm, ionic_radius=92.0 pm, ionic_potential=3.483e-9 C m⁻¹, origin=calculated, , most_reliable=false)
6  (Fe3+, coordination=IV, econf=3d5, spin=HS, crystal_radius=63.0 pm, ionic_radius=49.0 pm, ionic_potential=9.809e-9 C m⁻¹, most_reliable=true)
7  (Fe3+, coordination=V, econf=3d5, crystal_radius=72.0 pm, ionic_radius=58.0 pm, ionic_potential=8.287e-9 C m⁻¹, most_reliable=false)
8  (Fe3+, coordination=VI, econf=3d5, spin=LS, crystal_radius=69.0 pm, ionic_radius=55.0 pm, ionic_potential=8.739e-9 C m⁻¹, origin=from r^3 vs V plots, , most_reliable=false)
9  (Fe3+, coordination=VI, econf=3d5, spin=HS, crystal_radius=78.5 pm, ionic_radius=64.5 pm, ionic_potential=7.452e-9 C m⁻¹, origin=from r^3 vs V plots, , most_reliable=true)
10 (Fe3+, coordination=VIII, econf=3d5, spin=HS, crystal_radius=92.0 pm, ionic_radius=78.0 pm, ionic_potential=6.162e-9 C m⁻¹, most_reliable=false)
11 (Fe4+, coordination=VI, econf=3d4, crystal_radius=72.5 pm, ionic_radius=58.5 pm, ionic_potential=1.096e-8 C m⁻¹, origin=from r^3 vs V plots, , most_reliable=false)
12 (Fe6+, coordination=IV, econf=3d2, crystal_radius=39.0 pm, ionic_radius=25.0 pm, ionic_potential=3.845e-8 C m⁻¹, origin=from r^3 vs V plots, , most_reliable=false)
"""

@test feir(;charge=2) == feir[1:5]
@test feir(;spin=:HS) == feir[[1, 2, 4, 5, 6, 9, 10]]
@test feir(;charge=2, coordination=:VI) == feir[3:4]
@test feir(;charge=2, coordination=:VI, spin=:LS) == feir(;charge=2, coordination=:VI, spin=:LS, econf="3d6") == [feir[3]]
@test feir(;econf="3d5", coordination=:VI) == feir[8:9]

@test feir(;charge=2) == feir[1:5]
@test feir(;charge=2, coordination=:VI) == feir[[3, 4]]
@test feir(;charge=2, most_reliable=true) == [feir[4]]
@test isempty(feir(;charge=4, spin=:HS))

end
end