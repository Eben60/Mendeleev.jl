module Mtmp
using Unitful, Dates #, PeriodicTable,

function inst_elements(xs)
    e = Element_M[]
    # el = Element_M(xs[1]...)
    # @show length(xs)
    for x in xs
        # x = collect(x)
        # @show x[55]
        el = Element_M(collect(x)...)
        # @show el.name
        push!(e, el)
    end
    return e
    # return nothing
end

include("Element_M_def.jl")
t0 = time()
include("elements_data.jl")

# Element_M(x) = Element_M(x...)

# this way is slow
# EM(x) = Element_M(x...)
# function inst_elements(xs)
#     return map(EM, xs)
# end


include("Elements_M.jl")
include("synonym_fields.jl")
include("property_functions.jl")
include("reloads.jl")

e_st = 1
e_len = 118
t1 = time()

# ix = vcat(1:2, 11:12)
# ed = els_data[e_st:e_st+e_len-1]
# @show length(ed) # "well, we got elements_data"
# @show ed
# elements_arr = inst_elements(ed)
elements_arr = inst_elements(els_data[e_st:e_st+e_len-1])
els_data = nothing
# # elements_arr = inst_elements(els_data)
#
# # elements_arr = Vector{Element_M}(Element_M.(els_data[ix])) # no idea why not working without this type casting
t2 = time()
# @show "we are continuing"
# const ELEMENTS_M = Elements_M(Vector{Element_M}(elements_arr))  # no idea why not working without this type casting

const ELEMENTS_M = Elements_M(elements_arr)

t3 = time()

export Element_M # struct definition

export ELEMENTS_M # all elements data

t_read = t1-t0
t_init_arr = t2-t1
t_init_E_M = t3-t2
@show t_read, t_init_arr, t_init_E_M
#
#
# # (t_read, t_init_arr, t_init_E_M) = (0.577, 19.404, 1.419)
# # e_len = 20
#
end  # module Mtmp
