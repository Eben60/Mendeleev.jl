module Mendeleev
using SQLite, DataFrames, PeriodicTable, Unitful

include("make_struct.jl")
include("f_units.jl")
include("data_import.jl")

export Element_M # struct definition

export ELEMENTS_M # all elements data

end  # module Mendeleev
