# """
# The Checkdocs module exports the only function `checkdocs()`, which  apparently not used anywhere anymore

# """
module Checkdocs

function load_Mendeleev()
    if ! isdefined(@__MODULE__, :Mendeleev)
        println("loading Mendeleev.jl")
        @eval begin
            include(normpath(@__DIR__, "../../src/Mendeleev.jl"))
            using .Mendeleev
        end
        println(pkgversion(Mendeleev))
    else
        println(chem_elements.Li)
    end
end

function checkdocs(paths)
    (;fields_doc_fl) = paths
    ls = readlines(fields_doc_fl)

    re = r"(\| `)(\w+)(`\s+\|)"

    findprops(ls) = ([match(re, l)[2] for l in ls if !isnothing(match(re, l))])

    doc_props = findprops(ls)

    omit_i = 0
    for (i, l) in pairs(ls[end:-1:begin])
        if occursin("omitted in this package", l)
            global omit_i = i
            break
        end
    end

    props2omit = findprops(ls[end-9:end])

    setdiff!(doc_props, props2omit)
    doc_props = Symbol.(doc_props)

     F = chem_elements[:F]

    props_m = propertynames(F)

    not_impl = setdiff(doc_props, props_m)
    not_doc = setdiff(props_m, doc_props)
    return (;not_doc, not_impl)
end

"""
julia> not_impl
11-element Vector{Symbol}:
 :Allen
 :Allred
 :Cottrell
 :Ghosh
 :Gordy
 :Martynov
 :Mulliken
 :Nagle
 :Pauling
 :Sanderson
 :Li

 8-element Vector{Symbol}:
 :allotropes
 :critical_pressure
 :critical_temperature
 :default_allotrope
 :group_id
 :series_id
 :triple_point_pressure
 :triple_point_temperature

"""

"""
julia> not_impl
5-element Vector{Symbol}:
 :electrophilicity
 :en_mulliken
 :inchi
 :ionic_radii
 :source

 2-element Vector{Symbol}:
 :group_id
 :series_id

"""
end # module
