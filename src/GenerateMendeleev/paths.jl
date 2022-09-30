# local files
datadir = joinpath(@__DIR__ , "../../data/")
elements_src = joinpath(datadir , "elements.db")
tmp_dir = @get_scratch!("mendeleev_files")
elements_dbfile = joinpath(tmp_dir, "mendeleev-elements.db")
chembook_jsonfile = joinpath(datadir , "el_chembook.json")

# Mendeleev.jl files
function path_in_Mend(fl, path=nothing)
    if isnothing(path)
        path = normpath(@__DIR__ , "../../src/")
    end
    return normpath(path, fl)
end

struct_fl = path_in_Mend("Element_M_def.jl")
static_data_fl = path_in_Mend("elements_data.jl")
oxstate_fl = path_in_Mend("oxistates_data.jl")
screening_fl = path_in_Mend("screening_data.jl")
ionization_fl = path_in_Mend("ionization_data.jl")
isotopes_fl = path_in_Mend("isotopes_data.jl")

# const intNaN = -9223372033146270158 # big negative random value as proxy for NaN / missing
