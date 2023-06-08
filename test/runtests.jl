using Mendeleev

# using Test, Unitful
using Aqua
Aqua.test_all(Mendeleev)

include("GeneralTests.jl")
include("UnitfulUnitsTests.jl")
include("ScreeningConstantsTests.jl")
include("OxiStatesTests.jl")
include("GroupsSeriesTests.jl")
include("IonenergyTests.jl")
include("ReprTests.jl")
include("DefsTests.jl")
include("IonicRadiiTest.jl")
include("IsotopesTest.jl")
include("EnegTests.jl")
include("AllPropertiesTest.jl")
