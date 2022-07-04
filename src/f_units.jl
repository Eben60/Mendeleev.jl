
const f_units = Dict(
    :lattice_constant => u"angstrom",
    :atomic_volume => u"cm^3/mol",
    :electron_affinity => u"eV",
    :electrophilicity => u"eV",
    :en_allen => u"eV",
    :en_mulliken => u"eV",
    :density => u"g/cm^3",
    :specific_heat => u"J/(g*mol)",
    :boiling_point => u"K",
    :melting_point => u"K",
    :evaporation_heat => u"kJ/mol",
    :fusion_heat => u"kJ/mol",
    :gas_basicity => u"kJ/mol",
    :heat_of_formation => u"kJ/mol",
    :proton_affinity => u"kJ/mol",
    :abundance_crust => u"mg/kg",
    :abundance_sea => u"mg/L",
    :atomic_radius => u"pm",
    :atomic_radius_rahm => u"pm",
    :covalent_radius_bragg => u"pm",
    :covalent_radius_cordero => u"pm",
    :covalent_radius_pyykko => u"pm",
    :covalent_radius_pyykko_double => u"pm",
    :covalent_radius_pyykko_triple => u"pm",
    :metallic_radius => u"pm",
    :metallic_radius_c12 => u"pm",
    :vdw_radius => u"pm",
    :vdw_radius_alvarez => u"pm",
    :vdw_radius_batsanov => u"pm",
    :vdw_radius_bondi => u"pm",
    :vdw_radius_dreiding => u"pm",
    :vdw_radius_mm3 => u"pm",
    :vdw_radius_rt => u"pm",
    :vdw_radius_truhlar => u"pm",
    :vdw_radius_uff => u"pm",
    :thermal_conductivity => u"W/(m*K)",
    :atomic_weight => u"u",
)



function un_u(fud)
    fu1 = Dict{Symbol, String}()
    for k in keys(fud)
        s = string(fud[k])
        if occursin(" ", s)
            s = replace(s, " " => "*")
        end
        fu1[k] = "u\"$s\""
    end
    return fu1
end


fu1 = un_u(f_units)

# function maintype(t)
#     !(t isa Union) && return t
#     ts = Base.uniontypes(t)
#     d=setdiff(ts, [Missing])
#     @assert length(d)==1
#     return collect(d)[1]
# end
