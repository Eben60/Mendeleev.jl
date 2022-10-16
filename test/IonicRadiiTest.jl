module IonicRadiiTests
using Mendeleev, Test, Unitful
using Mendeleev: IonicRadius, IonicRadii # , ChemElem

@testset "IonicRadiiTests" begin

Cl = chem_elements[:Cl]
Cl1minus= Cl.ionic_radii[1]
Cl5plus = Cl.ionic_radii[2]

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

end
end