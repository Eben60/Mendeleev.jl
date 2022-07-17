module Mendeleev
using PeriodicTable, Unitful


include("Element_M_def.jl") # file just computer-generated
include("elements_data.jl")
Element_M(x) = Element_M(x...)
include("Elements_M.jl")
include("synonym_fields.jl")
include("reloads.jl")

elements_arr = Vector{Element_M}(Element_M.(els_data)) # no idea why not working without this type casting

const ELEMENTS_M = Elements_M(elements_arr)

export Element_M # struct definition

export ELEMENTS_M # all elements data

end  # module Mendeleev
