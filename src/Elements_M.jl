struct Elements_M
    data::Vector{Element_M}
    bynumber::Dict{Int,Element_M}
    byname::Dict{String,Element_M}
    bysymbol::Dict{Symbol,Element_M}
    Elements_M(data::Vector{Element_M}) = new(
        sort!(data, by=d->d.atomic_number),
        Dict{Int,Element_M}(d.atomic_number=>d for d in data),
        Dict{String,Element_M}(lowercase(d.name)=>d for d in data),
        Dict{Symbol,Element_M}(Symbol(d.symbol)=>d for d in data))
end
