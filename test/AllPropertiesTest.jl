module AllPropertiesTest
using Mendeleev, Test, Unitful

@testset "AllPropertiesTest" begin

None = missing

function check(x, v)
    (ismissing(v) || v == "") && return ismissing(x)
    v isa Union{String, Symbol} && return x == v
    return (x |> ustrip) ≈ v
end

Si = chem_elements.Si

@test check(Si.abundance_crust, 282000.0)
@test check(Si.abundance_sea, 2.2)
@test check(Si.allotropes, "")
@test check(Si.annotation, "")
@test check(Si.atomic_number, 14)
@test check(Si.atomic_radius, 110.0)
@test check(Si.atomic_radius_rahm, 231.99999999999997)
@test check(Si.atomic_volume, 12.1)
@test check(Si.atomic_weight, 28.085)
@test check(Si.atomic_weight_uncertainty, None)
@test check(Si.block, "p")
@test check(Si.boiling_point, 3538.15)
@test check(Si.c6, 305.0)
@test check(Si.c6_gb, 308.0)
@test check(Si.cas, "7440-21-3")
@test check(Si.covalent_radius_bragg, 117.0)
@test check(Si.covalent_radius_cordero, 111.00000000000001)
@test check(Si.covalent_radius_pyykko, 115.99999999999999)
@test check(Si.covalent_radius_pyykko_double, 107.0)
@test check(Si.covalent_radius_pyykko_triple, 102.0)
@test check(Si.critical_pressure, "")
@test check(Si.critical_temperature, "")
@test check(Si.cpk_color, "#daa520")
@test check(Si.default_allotrope, "")
@test check(Si.density, 2.3296)
@test check(Si.description, "Metalloid element belonging to group 14 of the periodic table. It is the second most abundant element in the Earth's crust, making up 25.7% of it by weight. Chemically less reactive than carbon. First identified by Lavoisier in 1787 and first isolated in 1823 by Berzelius.")
@test check(Si.dipole_polarizability, 37.3)
@test check(Si.dipole_polarizability_unc, 0.7)
@test check(Si.discoverers, "Jöns Berzelius")
@test check(Si.discovery_location, "Sweden")
@test check(Si.discovery_year, 1824)
@test check(Si.electron_affinity, 1.3895211)
@test check(Si.electrons, 14)
@test check(Si.evaporation_heat, 383.0)
@test check(Si.fusion_heat, 50.6)
@test check(Si.gas_basicity, 814.1)
@test check(Si.geochemical_class, "major")
@test check(Si.glawe_number, 85)
@test check(Si.goldschmidt_class, "litophile")
@test check(Si.group_id, 14)
@test check(Si.heat_of_formation, 450.0)
@test check(Si.inchi, "InchI=1S/Si")
@test check(Si.is_monoisotopic, false)
@test check(Si.is_radioactive, false)
@test check(Si.jmol_color, "#f0c8a0")
@test check(Si.lattice_constant, 5.43)
@test check(Si.lattice_structure, "DIA")
@test check(Si.mass_number, 28)
@test check(Si.melting_point, 1687.15)
@test check(Si.mendeleev_number, 88)
@test check(Si.metallic_radius, 117.0)
@test check(Si.metallic_radius_c12, 138.0)
@test check(Si.molar_heat_capacity, 19.99)
@test check(Si.molcas_gv_color, "#f0c8a0")
@test check(Si.name, "Silicon")
@test check(Si.name_origin, "Latin: silex, silicus, (flint).")
@test check(Si.neutrons, 14)
@test Si.nist_webbook_url == "https://webbook.nist.gov/cgi/inchi/InChI%3D1S/Si"
@test check(Si.period, 3)
@test check(Si.pettifor_number, 85)
@test check(Si.proton_affinity, 837.0)
@test check(Si.protons, 14)
@test check(Si.series, "Metalloids")
@test check(Si.sources, "Makes up major portion of clay, granite, quartz (SiO2), and sand. Commercial production depends on a reaction between sand (SiO2) and carbon at a temperature of around 2200 °C.")
@test check(Si.specific_heat_capacity, 0.712)
@test check(Si.symbol, :Si)
@test check(Si.thermal_conductivity, 149.0)
@test check(Si.triple_point_pressure, "")
@test check(Si.triple_point_temperature, "")
@test check(Si.uses, "Used in glass as silicon dioxide (SiO2). Silicon carbide (SiC) is one of the hardest substances known and used in polishing. Also the crystalline form is used in semiconductors.")
@test check(Si.vdw_radius, 210.0)
@test check(Si.vdw_radius_alvarez, 219.0)
@test check(Si.vdw_radius_batsanov, 210.0)
@test check(Si.vdw_radius_bondi, 210.0)
@test check(Si.vdw_radius_dreiding, 426.99999999999994)
@test check(Si.vdw_radius_mm3, 229.0)
@test check(Si.vdw_radius_rt, None)
@test check(Si.vdw_radius_truhlar, None)
@test check(Si.vdw_radius_uff, 429.5)

@test Si.appearance == "crystalline, reflective with bluish-tinged faces"
@test Si.atomic_mass ≈ 28.085u"u"
@test Si.boil ≈ 3538.15u"K"
@test Si.category == "metalloid"
@test Si.cpk_hex == "#daa520"
@test Si.discovered_by == "1824 by Jöns Berzelius in Sweden"
@test Si.el_config == "1s² 2s² 2p⁶ 3s² 3p²"
@test Si.electronic_configuration == "[Ne] 3s2 3p2"
@test Si.ionenergy[1] ≈ 8.151683u"eV"
@test Si.melt == Si.melting_point
@test Si.molar_heat == Si.molar_heat_capacity
@test Si.number == Si.atomic_number
@test Si.phase == "Solid"
@test Si.series_id == 5
@test Si.shells == [2,8,4]
@test Si.spectral_img == "https://en.wikipedia.org/wiki/File:Silicon_Spectra.jpg"
@test Si.summary == "Silicon is a chemical element with symbol Si and atomic number 14. It is a tetravalent metalloid, more reactive than germanium, the metalloid directly below it in the table. Controversy about silicon's character dates to its discovery."
@test Si.wikipedia == "https://en.wikipedia.org/wiki/Silicon"
@test Si.xpos == 14
@test Si.ypos == 3

@test Si.electrophilicity ≈ 1.6827934805482991u"eV"
@test Si.isotopes[1].mass ≈ 27.976926535u"u"
@test Si.ionic_radii[1].ionic_radius ≈ 26.0u"pm"
@test Si.sconst[1, 1].screening == 0.4255
@test Si.group.name == "Carbon group"
@test Si.oxistates == [-4, 4]

N = chem_elements.N

@test N.critical_pressure  ≈ 3.3958u"MPa"
@test N.critical_temperature  ≈ 126.192u"K"
@test N.triple_point_pressure  ≈ 12.52u"kPa"
@test N.triple_point_temperature  ≈ 63.151u"K"

C = chem_elements.C

@test C.default_allotrope == "graphite"
@test C.allotropes == ["graphite", "diamond"]

end # testset
end # module