module Mtmp
using PeriodicTable, Unitful, Dates


include("Element_M_def.jl")
t0 = time()
include("elements_data.jl")

Element_M(x) = Element_M(x...)
include("Elements_M.jl")
include("synonym_fields.jl")
include("reloads.jl")

e_st = 1
e_len = 20
t1 = time()

elements_arr = Vector{Element_M}(Element_M.(els_data[e_st:e_len])) # no idea why not working without this type casting
# ix = vcat(1:2, 11:12)
# elements_arr = Vector{Element_M}(Element_M.(els_data[ix])) # no idea why not working without this type casting
t2 = time()

const ELEMENTS_M = Elements_M(elements_arr)
t3 = time()

export Element_M # struct definition

export ELEMENTS_M # all elements data

t_read = t1-t0
t_init_arr = t2-t1
t_init_E_M = t3-t2
@show t_read, t_init_arr, t_init_E_M


# (t_read, t_init_arr, t_init_E_M) = (0.577, 19.404, 1.419)
# e_len = 20

end  # module Mtmp
