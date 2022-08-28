module UnitfulUnitsTests
using Mendeleev, Test, Unitful
import Unitful: u, g, cm, K, J, mol

# Unitful units
H = ELEMENTS_M[1]
@test unit(H.density) === g/cm^3
@test unit(H.boil) === K
@test unit(H.melt) === K
@test unit(H.molar_heat) == J/(mol*K)
@test unit(H.atomic_mass) === u

end
