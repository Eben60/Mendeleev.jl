module Mendeleev
using Unitful #, PeriodicTable

function inst_elements(xs)
    e = Element_M[]
    for x in xs
        push!(e, Element_M(collect(x)...)) # Julia hangs without collect - probably a bug
    end
    return e
end


include("Element_M_def.jl")
include("elements_data.jl")
Element_M(x) = Element_M(x...)
include("Elements_M.jl")
include("synonym_fields.jl")
include("property_functions.jl")
include("reloads.jl")

elements_arr = inst_elements(els_data)
els_data = nothing
const ELEMENTS_M = Elements_M(elements_arr)

export Element_M # struct definition
export ELEMENTS_M # all elements data

end  # module Mendeleev
