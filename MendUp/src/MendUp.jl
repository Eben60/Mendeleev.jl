"""
The MendUp module updates files in the (separate) Mendeleev.jl package.
Usage is as following
# Examples
```julia-repl
julia> MendUp; MendeleevUpdateHelper.mend_upd(;dev=false)
```
"""
module MendUp
using SQLite, DataFrames, Tables, PeriodicTable # Unitful, 
using JSONTables
using Scratch

d = @__DIR__
inclpath(fl) = normpath(d, fl)

# TODO somehow set path before runnung the whole package
# path_m = normpath(d, "../../Mendeleev.jl/src")

include("get_mend_dbfile.jl")

include("getpaths.jl")
paths = getpaths()

include("check_docs.jl")

include(path_in_Mend("data.jl/seriesnames.jl")) # part of Mendeleev
include(path_in_Mend("Group_M_def_data.jl")) # part of Mendeleev
include(path_in_Mend("property_functions.jl")) # part of Mendeleev
include(path_in_Mend("synonym_fields.jl")) # part of Mendeleev
include(path_in_Mend("screeniningconsts_def.jl")) # part of Mendeleev

include("PeriodicTable2df.jl")
include("make_struct.jl")
include("els_data_import.jl")
include("more_data_import.jl")
include("Isotopes.jl")
include("make_static_data.jl")
include("ionicradii.jl")
include("read_en_lixue.jl")
include("make_data_through_python.jl")

"""
    mend_upd(;dev=true, update_db=false, paths=paths, ret = false)
`update_db` can be `Bool` or the Symbol `:restore`

`ret` defines whether the function returns (a lot of) data, or `nothing`
"""
function mend_upd(;dev=true, update_db=false, paths=paths, ret = false)
    (;static_data_fl, screening_fl, ionization_fl, ionicradii_fl) = paths


    # to actually write data to Mendeleev.jl, set dev = false
    dev = dev || update_db # only write to Mendeleev.jl after you controlled the changes of the database
    # if dev
    #     @eval using Mendeleev
    # end

    dfpt = periodictable2df()

    els_data = els_data_import(dfpt, update_db)

    (;vs, scr, ion) = more_data_import(els_data)

    irs = ionicradii(els_data)

    els_data = merge(els_data, (;ion, scr, irs))

    if ! dev
        # make_chem_elements(elements_init_data, els)
        make_elements_data(static_data_fl, els_data)

        # make_static_data(static_data_fl, vs, f_unames)
        make_screening_data(screening_fl, els_data)
        make_ionization_data(ionization_fl, els_data)
        make_irad_data(ionicradii_fl, els_data)

        make_ephil_data() # via calling Python
        make_lixue_data() # via calling Python

        # d_isot = isotopes(els_data)
        # (;isotopes_fl) = paths 
        # make_isotopes_data(isotopes_fl, d_isot, els_data) # temporary, or at least until py-mendeleev checked and found OK

        # oxidation states are my own work now, no import from Mendeleev db
        # (;oxstate_fl) = paths
        # make_oxstates_data(oxstate_fl)
    end
    !ret && return nothing
    return (; els_data, paths)
end # mend_upd
# export mend_upd

load_Mendeleev = Checkdocs.load_Mendeleev
checkdocs = Checkdocs.checkdocs

# function upd_mend1(m_path=nothing; dev = false)
#     if ! dev
#         write_struct_jl(struct_fl, s_def_text)
#     end
#     return nothing
# end

# function upd_mend2(m_path=nothing; dev = false)
#     if ! dev
#          include(inclpath("make_static_data.jl"))
#     end
#     return nothing
# end

# function upd_mend3(m_path=nothing; dev = false)
#     if ! dev
#         make_isotopes_data(isotopes_fl)
#         make_static_data(static_data_fl, vs, f_unames)
#         make_screening_data(screening_fl)
#         make_ionization_data(ionization_fl)

#         # oxidation states are my own work now, no import from Mendeleev db
#         # make_oxstates_data(oxstate_fl)
#     end
#     return nothing
# end
# 
# export upd_mend1, upd_mend2, upd_mend3

end  # module MendeleevUpdateHelper
