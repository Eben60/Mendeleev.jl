module Generate_MFiles
using SQLite, DataFrames, Tables, Unitful, PeriodicTable
using JSONTables
using Scratch

dev = false

include("paths.jl")
include("../units.jl") # part of Mendeleev
include("../seriesnames.jl") # part of Mendeleev
include("../Group_M_def_data.jl") # part of Mendeleev
include("../synonym_fields.jl") # part of Mendeleev
include("../screeniningconsts_def.jl") # part of Mendeleev
include("PeriodicTable2df.jl")
include("make_struct.jl")
include("utype2str.jl")
include("f_units.jl")
include("data_import.jl")
if ! dev
    write_struct_jl(struct_fl, s_def_text)
    include("../Element_M_def.jl") # file just computer-generated - will be part of Mendeleev
    include("Isotopes.jl")
end
    include("make_static_data.jl")
if ! dev
    make_static_data(static_data_fl, vs, f_unames)
    make_screening_data(screening_fl)
    make_ionization_data(ionization_fl)

    # oxidation states are my own work now, no import from Mendeleev db
    # make_oxstates_data(oxstate_fl)
end

end  # module Generate_MFiles
