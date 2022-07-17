module Mendeleev
using SQLite, DataFrames, PeriodicTable, Unitful
using Scratch, Pkg.TOML

# https://discourse.julialang.org/t/julia-depot-path-and-julia-project/73745/26
# https://discourse.julialang.org/t/using-scratch-space-as-a-time-limited-cache/76849
# https://discourse.julialang.org/t/ann-scratch-jl-package-specific-mutable-data-containers/45855
# https://github.com/JuliaPackaging/Scratch.jl
# using Scratch

function get_version()
    return VersionNumber(TOML.parsefile(joinpath(dirname(@__DIR__), "Project.toml"))["version"])
end
const pkg_version = get_version()



include("constants.jl")
include("make_struct.jl")
include("utype2str.jl")
include("f_units.jl")
include("data_import.jl")
include("Element_M_def.jl") # file just computer-generated
Element_M(x) = Element_M(x...)
include("Elements_M.jl")
include("reloads.jl")

#
# const elements_arr = inst_elements(vs)
#
# const ELEMENTS_M = Elements_M(elements_arr)


export Element_M # struct definition

export ELEMENTS_M # all elements data

end  # module Mendeleev
