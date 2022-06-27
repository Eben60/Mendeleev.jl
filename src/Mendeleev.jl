__precompile__(true) # try for the time being

module Mendeleev

using SQLite, DataFrames, PeriodicTable

using Dates

include("make_struct.jl")
include("unmiss.jl")
include("data_import.jl")

export Element_M # struct definition

export ELEMENTS_M # all elements data

end  # module Mendeleev
