function s2d(s, print=true)
    fields = fieldnames(typeof(s))
    d = Dict(f => getfield(s, f) for f in fields)
    for k in keys(d)
        println(Pair(k, d[k]))
    end
    return d
end
