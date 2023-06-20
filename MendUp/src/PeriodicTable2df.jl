# using PeriodicTable

# read all data to be taken over from PeriodicTable package into a DataFrame

function periodictable2df()
    fnms = fieldnames(eltype(elements))
    nt(e) = NamedTuple([f => getfield(e, f) for f in fnms])
    dfpt = DataFrame(nt.(elements))

    rename!(dfpt, properties2rename)
    toexclude = unique(vcat(collect(keys(synonym_fields)), calculated_properties, properties2omit))

    nms2 = Symbol.(names(dfpt))
    toexclude = intersect(toexclude, nms2)

    select!(dfpt, Not(toexclude))
    return dfpt
end