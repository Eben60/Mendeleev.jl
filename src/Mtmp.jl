module Mtmp
using PeriodicTable, Unitful, Dates


include("Element_M_def.jl")
t0 = time()
include("elements_data.jl")

Element_M(x) = Element_M(x...)

function inst_elements(xs)
    e = Element_M[]
    for x in xs
        push!(e, Element_M(x...))
    end
    return e
end


include("Elements_M.jl")
include("synonym_fields.jl")
include("reloads.jl")

e_st = 1
e_len = 20
t1 = time()

# ix = vcat(1:2, 11:12)
# elements_arr = inst_elements(els_data[e_st:e_st+e_len-1])

elements_arr = inst_elements(els_data)

# elements_arr = Vector{Element_M}(Element_M.(els_data[ix])) # no idea why not working without this type casting
t2 = time()

# const ELEMENTS_M = Elements_M(Vector{Element_M}(elements_arr))  # no idea why not working without this type casting

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
