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
include("screeniningconsts_def.jl")
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
        # oxidation states are my own work now
        # make_oxstates_data(oxstate_fl)
    make_screening_data(screening_fl)
end
make_ionization_data(ionization_fl)
end  # module Generate_MFiles
