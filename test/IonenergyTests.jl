module IonenergyTests
using Mendeleev, Test, Unitful

K = chem_elements[:K]
Ts = chem_elements[:Ts]

@test length(K.ionenergy) == K.number
@test K.ionenergy[9] == 175.8174u"eV"
@test ismissing(Ts.ionenergy)

end # module
