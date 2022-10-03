module PropertiesTests
using Mendeleev, Test

K = chem_elements[:K]
He = chem_elements[:He]
N = chem_elements[:N]
Ts = chem_elements[:Ts]

@test K.nist_webbook_url == "https://webbook.nist.gov/cgi/inchi/InChI%3D1S/K"


end # module
