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
He3a = Isotope(2, 3, 3.01602932, 2e-6)
He3b = Isotope(2, 3, NaN, NaN)
@test isequal(He3, He3b) # only element and mass numbers count
@test He3.mass ≈ He3a.mass ≈ 3.01602932u"u"
@test He3.abundance ≈ He3a.abundance ≈ 2e-6
@test He3.atomic_number == He3a.atomic_number == 2
@test He3.mass_number == He3a.mass_number == 3

function abund_total(e; rtol = 1e-5)
    isots = e.isotopes
    ismissing(isots) && return (; ok = true, total = 0)
    total = sum([isot.abundance for isot in isots])
    ok = isapprox(1.0, total; rtol)
    return (;ok, total)
end

@test all([abund_total(e; rtol=5e-5).ok for e in chem_elements]) 

end # @testset
end # module