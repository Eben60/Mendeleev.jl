const f_unames = Dict(
    :lattice_constant => "angstrom",
    :atomic_volume => "cm^3/mol",
    :electron_affinity => "eV",
    :electrophilicity => "eV",
    :en_allen => "eV",
    :en_mulliken => "eV",
    :density => "g/cm^3",
    :specific_heat => "J/(g*K)",
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
)

function s2unit(s)
    s1 = "u\"$s\""
    x = eval(Meta.parse(s1))
    return x
end

const f_units = Dict(k => s2unit(v) for (k, v) in f_unames)

const synonym_fields = Dict(
    :atomic_mass => :atomic_weight,
    :boil => :boiling_point,
    :cpk_hex => :cpk_color,
    :discovered_by => :discoverers,
    :melt => :melting_point,
    :number => :atomic_number,
    )

struct_fl = "src/Element_M_def.jl"
static_data_fl = "src/elements_data.jl"
