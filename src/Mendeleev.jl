module Mendeleev
using SQLite, DataFrames, PeriodicTable

include("make_struct.jl")
include("data_import.jl")

export Element_M # struct definition

export ELEMENTS_M # all elements data

end  # module Mendeleev
