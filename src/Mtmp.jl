module Mtmp
using PeriodicTable, Unitful, Dates


include("Element_M_def.jl")
include("elements_data.jl")
Element_M(x) = Element_M(x...)
include("Elements_M_tmp.jl")
include("synonym_fields.jl")
include("reloads_tmp.jl")

e_st = 1
e_len = 118
t0 = time()

elements_arr = Vector{Element_M}(Element_M.(els_data[e_st:e_len])) # no idea why not working without this type casting
# ix = vcat(1:2, 11:12)
# elements_arr = Vector{Element_M}(Element_M.(els_data[ix])) # no idea why not working without this type casting
t1 = time()

const ELEMENTS_M = Elements_M(elements_arr)
t2 = time()

export Element_M # struct definition

export ELEMENTS_M # all elements data

t_read = t1-t0
t_init = t2-t1
@show t_read, t_init

end  # module Mtmp
