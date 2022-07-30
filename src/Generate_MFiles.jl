module Generate_MFiles
using SQLite, DataFrames, PeriodicTable, Unitful
using JSONTables
using Scratch, Pkg.TOML

dev = false

function get_version()
    return VersionNumber(TOML.parsefile(joinpath(dirname(@__DIR__), "Project.toml"))["version"])
end
const pkg_version = get_version()

include("constants.jl")
include("seriesnames.jl")
include("Group_M_def_data.jl")
include("synonym_fields.jl")
include("PeriodicTable2df.jl")
include("make_struct.jl")
include("utype2str.jl")
include("f_units.jl")
include("data_import.jl")
if ! dev
    write_struct_jl(struct_fl, s_def_text)
    include("Element_M_def.jl") # file just computer-generated
end
    include("make_static_data.jl")
if ! dev
    make_static_data(static_data_fl, vs, f_unames)
    make_oxstates_data(oxstate_fl)
end

end  # module Generate_MFiles
