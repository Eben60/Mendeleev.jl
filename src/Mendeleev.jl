module Mendeleev
using Unitful

include("seriesnames.jl")
include("oxistates_data.jl")
include("Group_M_def_data.jl")
include("screeniningconsts_def.jl")
include("screening_data.jl")
include("ionization_data.jl")
include("isotopes_def.jl")
include("isotopes_data.jl")
include("Element_M_def.jl")
include("elements_data.jl")
include("Elements_M.jl")
include("elements_init.jl")
include("synonym_fields.jl")
include("property_functions.jl")
include("overloads.jl")

els = ELEMENTS_M
export Element_M # struct definition
export ELEMENTS_M, els # all elements data

end  # module Mendeleev
