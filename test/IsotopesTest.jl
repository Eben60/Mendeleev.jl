module IsotopesTests
using Mendeleev, Test, Unitful
using Mendeleev: Isotope, Isotopes, ChemElem

@testset "IsotopesTests" begin

Eth = ChemElem(0, "Ether", :Eth)

Eth0 = Isotope(0, 0, 0.01, 1.00)
@test Eth0.mass == 0.01u"u"

He3 = chem_elements[:He].isotopes[1]
Eth_istp = Isotopes([Eth0, He3])
@test Eth_istp[1].abundance == 1.0
@test Eth_istp[1:2] == [Eth0, He3] == collect(Eth_istp)

@test Eth0 < He3
@test isequal(He3, Isotope(2, 3, 0.02, 3.00)) # only element and mass numbers count
@test_broken He3 == Isotope(2, 3, 0.02, 3.00) # why?

end
end