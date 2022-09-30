datadir = joinpath(@__DIR__ , "../../data/")

elements_src = joinpath(datadir , "elements.db")
tmp_dir = @get_scratch!("mendeleev_files")
elements_dbfile = joinpath(tmp_dir, "mendeleev-elements.db")
chembook_jsonfile = joinpath(datadir , "el_chembook.json")

struct_fl = "src/Element_M_def.jl"
static_data_fl = "src/elements_data.jl"
oxstate_fl = "src/oxistates_data.jl"
screening_fl = "src/screening_data.jl"
ionization_fl = "src/ionization_data.jl"
isotopes_fl = "src/isotopes_data.jl"

# const intNaN = -9223372033146270158 # big negative random value as proxy for NaN / missing
