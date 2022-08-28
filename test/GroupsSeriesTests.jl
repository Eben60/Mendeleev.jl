module GroupsSeriesTests
using Mendeleev, Test

Group_M = Mendeleev.Group_M

He = ELEMENTS_M[:He]
N = ELEMENTS_M[:N]
Cu = ELEMENTS_M[:Cu]
Zr = ELEMENTS_M[:Zr]
Sn = ELEMENTS_M[:Sn]

@test N.group == Group_M(15, "VA", "Pnictogens")
@test Cu.group == Group_M(11, "IB", "Coinage metals")

@test Cu.group.no == 11
@test Cu.group.name == "Coinage metals"
@test Cu.group.symbol == "IB"

@test repr(Cu.group) == "11[IB] (Coinage metals)"
@test repr(Zr.group) == "4[IVB]"

@test Cu.series == "Transition metals"
@test He.series == "Noble gases"
@test Sn.series == "Poor metals"
end # module
