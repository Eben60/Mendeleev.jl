    # Mendeleev.jl files
function path_in_Mend(fl, path=nothing)
    if isnothing(path)
        path = normpath(@__DIR__ , "../../src/")
    end
    p = normpath(path, fl)
    if ! ispath(p)
        error("file $p not found")
    end
    return p
end

function getpaths()
    # local files
    datadir = normpath(@__DIR__ , "../data/")
    elements_src = normpath(datadir , "elements.db")
    tmp_dir = @get_scratch!("mendeleev_files")
    elements_dbfile = normpath(tmp_dir, "mendeleev-elements.db")
    chembook_jsonfile = normpath(datadir , "el_chembook.json")

    # python_db_file = "~/Library/Python/3.9/lib/python/site-packages/mendeleev/elements.db"



    path_docs = normpath(@__DIR__, "../../docs/src/")

    # elements_init_data = path_in_Mend("elements_init.jl")
    mendeleev_fl = path_in_Mend("Mendeleev.jl")
    static_data_fl = path_in_Mend("data.jl/elements_data.jl")
    oxstate_fl = path_in_Mend("data.jl/oxistates_data.jl")
    screening_fl = path_in_Mend("data.jl/screening_data.jl")
    ionization_fl = path_in_Mend("data.jl/ionization_data.jl")
    isotopes_fl = path_in_Mend("data.jl/isotopes_data.jl")

    ephil_data = "ephil_data.jl"
    ephil_data_Mend = path_in_Mend(joinpath("data.jl", ephil_data))
    ephil_data_loc = normpath(datadir, ephil_data)

    lixue_data = "lixue_data.jl"
    lixue_data_Mend = path_in_Mend(joinpath("data.jl", lixue_data))
    lixue_data_loc = normpath(datadir, lixue_data)

    fields_doc_fl = path_in_Mend("elements_data_fields.md", path_docs)

    ionicradii_fl = path_in_Mend("data.jl/ionrad_data.jl") 

    db_struct_prev_fl = normpath(datadir , "db_struct_prev.jl")
    db_struct_new_fl = normpath(datadir , "db_struct_new.jl")

    @assert ispath(fields_doc_fl)
    # return (;elements_src, ... 
    return (;elements_dbfile, chembook_jsonfile, elements_src, mendeleev_fl,
        static_data_fl, oxstate_fl, screening_fl, ionization_fl, isotopes_fl, 
        fields_doc_fl, ionicradii_fl, db_struct_prev_fl, db_struct_new_fl,
        ephil_data_loc, ephil_data_Mend,  lixue_data_loc, lixue_data_Mend)
end