from mendeleev import element
Si = element('Si')
pns = ["Si.abundance_crust", "Si.abundance_sea", "Si.annotation", "Si.appearance", "Si.atomic_mass", "Si.atomic_number", "Si.atomic_radius", "Si.atomic_radius_rahm", "Si.atomic_volume", "Si.atomic_weight", "Si.atomic_weight_uncertainty", "Si.block", "Si.boil", "Si.boiling_point", "Si.c6", "Si.c6_gb", "Si.cas", "Si.category", "Si.covalent_radius_bragg", "Si.covalent_radius_cordero", "Si.covalent_radius_pyykko", "Si.covalent_radius_pyykko_double", "Si.covalent_radius_pyykko_triple", "Si.cpk_color", "Si.cpk_hex", "Si.density", "Si.description", "Si.dipole_polarizability", "Si.dipole_polarizability_unc", "Si.discovered_by", "Si.discoverers", "Si.discovery_location", "Si.discovery_year", "Si.el_config", "Si.electron_affinity", "Si.electronic_configuration", "Si.electrons", "Si.electrophilicity", "Si.eneg", "Si.evaporation_heat", "Si.fusion_heat", "Si.gas_basicity", "Si.geochemical_class", "Si.glawe_number", "Si.goldschmidt_class", "Si.group", "Si.group_id", "Si.heat_of_formation", "Si.inchi", "Si.ionenergy", "Si.ionic_radii", "Si.is_monoisotopic", "Si.is_radioactive", "Si.isotopes", "Si.jmol_color", "Si.lattice_constant", "Si.lattice_structure", "Si.mass_number", "Si.melt", "Si.melting_point", "Si.mendeleev_number", "Si.metallic_radius", "Si.metallic_radius_c12", "Si.molar_heat", "Si.molar_heat_capacity", "Si.molcas_gv_color", "Si.name", "Si.name_origin", "Si.neutrons", "Si.nist_webbook_url", "Si.number", "Si.oxistates", "Si.period", "Si.pettifor_number", "Si.phase", "Si.proton_affinity", "Si.protons", "Si.sconst", "Si.series", "Si.series_id", "Si.shells", "Si.sources", "Si.specific_heat_capacity", "Si.spectral_img", "Si.summary", "Si.symbol", "Si.thermal_conductivity", "Si.uses", "Si.vdw_radius", "Si.vdw_radius_alvarez", "Si.vdw_radius_batsanov", "Si.vdw_radius_bondi", "Si.vdw_radius_dreiding", "Si.vdw_radius_mm3", "Si.vdw_radius_rt", "Si.vdw_radius_truhlar", "Si.vdw_radius_uff", "Si.wikipedia", "Si.xpos", "Si.ypos"]

# print(pns[1], eval(pns[1]))

propd = {}

for p in pns:
    if not (p in ["Si.isotopes", "Si.ionic_radii", "Si.sconst", "Si.group", "Si.screening_constants", "Si.electrophilicity", "Si.oxistates"]):
        try:
            propd.update({p : eval(p)})
        except:
            propd.update({p : "n.a."})
    else:
        print("skipping ", p)

# print(propd )

for p in propd.keys():
    v = propd[p]
    if not v == "n.a." :
        if isinstance(v, str):
            v = '"' + v + '"' 
        s = "    @test check(" + p + ", " + str(v) + ")"
        print(s)
         #print(p, ", ", v)   
for p in propd.keys():
    v = propd[p]
    if v == "n.a." :
        print(p)
