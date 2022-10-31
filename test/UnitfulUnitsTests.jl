module UnitfulUnitsTests
using Mendeleev, Test, Unitful
using Unitful: u, g, cm, K, J, mol
@testset "UnitfulUnitsTests" begin

H = chem_elements[1]
O = chem_elements[:O]
Zr = chem_elements[:Zr]
Be = chem_elements[:Be]

@test unit(H.density) === g/cm^3
@test unit(H.boil) === K
@test unit(H.melt) === K
@test unit(H.molar_heat) === J/(mol*K)
@test unit(H.atomic_mass) === u

@test unit(H.lattice_constant) === u"angstrom"
@test unit(H.atomic_volume) === u"cm^3/mol"
@test unit(H.electron_affinity) === u"eV"
@test unit(H.electrophilicity) === u"eV" 
@test unit(H.eneg.Allen) === u"eV"
@test unit(H.density) === u"g/cm^3"
@test unit(H.specific_heat_capacity) === u"J/(g*K)"
@test unit(H.boiling_point) === u"K"
@test unit(H.melting_point) === u"K"
@test unit(H.evaporation_heat) === u"kJ/mol"
@test unit(H.fusion_heat) === u"kJ/mol"
@test unit(O.gas_basicity) === u"kJ/mol"
@test unit(H.heat_of_formation) === u"kJ/mol"
@test unit(O.proton_affinity) === u"kJ/mol"
@test unit(H.abundance_crust) === u"mg/kg"
@test unit(H.abundance_sea) === u"mg/L"
@test unit(H.atomic_radius) === u"pm"
@test unit(H.atomic_radius_rahm) === u"pm"
@test unit(O.covalent_radius_bragg) === u"pm"
@test unit(Zr.covalent_radius_cordero) === u"pm"
@test unit(Zr.covalent_radius_pyykko) === u"pm"
@test unit(Zr.covalent_radius_pyykko_double) === u"pm"
@test unit(Zr.covalent_radius_pyykko_triple) === u"pm"
@test unit(Zr.metallic_radius) === u"pm"
@test unit(Zr.metallic_radius_c12) === u"pm"
@test unit(Zr.molar_heat_capacity) === u"J/(mol*K)"
@test unit(Zr.vdw_radius) === u"pm"
@test unit(Zr.vdw_radius_alvarez) === u"pm"
@test unit(Zr.vdw_radius_batsanov) === u"pm"
@test unit(O.vdw_radius_bondi) === u"pm"
@test unit(O.vdw_radius_dreiding) === u"pm"
@test unit(O.vdw_radius_mm3) === u"pm"
@test unit(O.vdw_radius_rt) === u"pm"
@test unit(Be.vdw_radius_truhlar) === u"pm"
@test unit(O.vdw_radius_uff) === u"pm"
@test unit(Zr.thermal_conductivity) === u"W/(m*K)"
@test unit(H.atomic_weight) === u"u"
@test unit(Zr.ionenergy[2]) === u"eV"

end
end
