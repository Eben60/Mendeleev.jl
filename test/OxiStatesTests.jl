module OxiStatesTests
using Mendeleev, Test

K = chem_elements[:K]
He = chem_elements[:He]
N = chem_elements[:N]
Ts = chem_elements[:Ts]

@test K.oxistates == [1]
@test N.oxistates == [-3, 3, 5]
@test isempty(He.oxistates)
@test ismissing(Ts.oxistates)

end # module
