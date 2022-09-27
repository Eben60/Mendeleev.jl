
# def electronegativity_allred_rochow(self, radius="covalent_radius_pyykko") -> float:
#     "Allred-Rochow's electronegativity"
#     return allred_rochow(self.zeff(), getattr(self, radius))
"""
Calculate the electronegativity of an atom according to the definition
of Allred and Rochow
Args:
    zeff: effective nuclear charge
    radius: value of the radius
"""
# def allred_rochow(zeff: float, radius: float) -> float:
#
#     return zeff / math.pow(radius, 2)

function fn_en_allred_rochow(e::Element_M)
    radius = e.covalent_radius_pyykko

end
