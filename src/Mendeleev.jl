module Mendeleev
using SQLite, DataFrames, PeriodicTable, Unitful, Scratch

# https://discourse.julialang.org/t/julia-depot-path-and-julia-project/73745/26
# https://discourse.julialang.org/t/using-scratch-space-as-a-time-limited-cache/76849
# https://discourse.julialang.org/t/ann-scratch-jl-package-specific-mutable-data-containers/45855
# https://github.com/JuliaPackaging/Scratch.jl
# using Scratch

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
