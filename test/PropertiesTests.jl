module PropertiesTests
using Mendeleev, Test

@testset "PropertiesTests" begin
K = chem_elements[:K]
He = chem_elements[:He]
N = chem_elements[:N]
Fe = chem_elements[:Fe]
Ts = chem_elements[:Ts]

@test K.nist_webbook_url == "https://webbook.nist.gov/cgi/inchi/InChI%3D1S/K"
@test Fe.electrons == Fe.protons == Fe.number = Fe.atomic_number = 26
@test Fe.mass_number == 56
@test Fe.neutrons == 30
@test ismissing(Ts.mass_number)
@test Fe.inchi == "InchI=1S/Fe"
@test els.H.inchi == "InchI=1S/H"
@test els.Og.inchi == "InchI=1S/Og"

end # @testset "PropertiesTests"
end # module
