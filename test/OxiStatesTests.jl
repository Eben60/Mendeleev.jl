module OxiStatesTests
using Mendeleev, Test

K = ELEMENTS_M[:K]
He = ELEMENTS_M[:He]
N = ELEMENTS_M[:N]
Ts = ELEMENTS_M[:Ts]

@test K.oxistates == [1]
@test N.oxistates == [-3, 3, 5]
@test isempty(He.oxistates)
@test ismissing(Ts.oxistates)

end # module
