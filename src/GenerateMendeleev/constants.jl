const f_unames = Dict(
    :lattice_constant => "angstrom",
    :atomic_volume => "cm^3/mol",
    :electron_affinity => "eV",
    :electrophilicity => "eV",
    :en_allen => "eV",
    :en_mulliken => "eV",
    :density => "g/cm^3",
    :specific_heat_capacity => "J/(g*K)",
    :boiling_point => "K",
    :melting_point => "K",
    :evaporation_heat => "kJ/mol",
    :fusion_heat => "kJ/mol",
    :gas_basicity => "kJ/mol",
    :heat_of_formation => "kJ/mol",
    :proton_affinity => "kJ/mol",
    :abundance_crust => "mg/kg",
    :abundance_sea => "mg/L",
    :atomic_radius => "pm",
    :atomic_radius_rahm => "pm",
    :covalent_radius_bragg => "pm",
    :covalent_radius_cordero => "pm",
    :covalent_radius_pyykko => "pm",
    :covalent_radius_pyykko_double => "pm",
    :covalent_radius_pyykko_triple => "pm",
    :metallic_radius => "pm",
    :metallic_radius_c12 => "pm",
    :molar_heat_capacity => "J/(mol*K)",
    :vdw_radius => "pm",
    :vdw_radius_alvarez => "pm",
    :vdw_radius_batsanov => "pm",
    :vdw_radius_bondi => "pm",
    :vdw_radius_dreiding => "pm",
    :vdw_radius_mm3 => "pm",
    :vdw_radius_rt => "pm",
    :vdw_radius_truhlar => "pm",
    :vdw_radius_uff => "pm",
    :thermal_conductivity => "W/(m*K)",
    :atomic_weight => "u",
    :ionenergy => "eV"
)

function s2unit(s)
    s1 = "u\"$s\""
    x = eval(Meta.parse(s1))
    return x
end

const f_units = Dict(k => s2unit(v) for (k, v) in f_unames)

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
