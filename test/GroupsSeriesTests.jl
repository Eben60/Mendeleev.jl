module GroupsSeriesTests
using Mendeleev, Test
using Mendeleev: Group_M

@testset "GroupsSeriesTests" begin

He = chem_elements[:He]
N = chem_elements[:N]
Cu = chem_elements[:Cu]
Zr = chem_elements[:Zr]
Sn = chem_elements[:Sn]

@test N.group == Group_M(15, "VA", "Pnictogens")
@test Cu.group == Group_M(11, "IB", "Coinage metals")

@test Cu.group.no == 11
@test Cu.group.name == "Coinage metals"
@test Cu.group.symbol == "IB"


@test Cu.series == "Transition metals"
@test He.series == "Noble gases"
@test Sn.series == "Poor metals"

end # @testset "GroupsSeriesTests" 
end # module
