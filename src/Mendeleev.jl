module Mendeleev
using SQLite, DataFrames, PeriodicTable, Unitful

include("constants.jl")
include("make_struct.jl")
include("utype2str.jl")
include("f_units.jl")
include("data_import.jl")
include("Elements_M.jl")


const elements_arr = inst_elements(vs)

const ELEMENTS_M = Elements_M(elements_arr)


export Element_M # struct definition

export ELEMENTS_M # all elements data

end  # module Mendeleev
