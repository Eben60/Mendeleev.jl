module Generate_MFiles
using SQLite, DataFrames, PeriodicTable, Unitful
using Scratch, Pkg.TOML


function get_version()
    return VersionNumber(TOML.parsefile(joinpath(dirname(@__DIR__), "Project.toml"))["version"])
end
const pkg_version = get_version()



include("constants.jl")
include("synonym_fields.jl")
include("make_struct.jl")
include("utype2str.jl")
include("f_units.jl")
include("data_import.jl")
include("Element_M_def.jl") # file just computer-generated
include("make_static_data.jl")
make_static_data(static_data_fl, vs, f_unames)

end  # module Generate_MFiles
