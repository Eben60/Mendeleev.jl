module IonenergyTests
using Mendeleev, Test

K = ELEMENTS_M[:K]
Ts = ELEMENTS_M[:Ts]

@test length(K.ionenergy) == K.number
@test K.ionenergy[9] == 175.8174
@test ismissing(Ts.ionenergy)

end # module
