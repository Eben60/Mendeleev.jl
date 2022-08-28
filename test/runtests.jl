using Mendeleev, Unitful
using Test

# TODO use repr instead of Base64.stringmime

elements = ELEMENTS_M

# test element lookup
O = elements[8]
F = elements[9]
@test O === elements["oxygen"] == elements[:O]
@test O != elements[:F]

include("ScreeningConstantsTests.jl")
include("OxiStatesTests.jl")
include("GroupsSeriesTests.jl")
