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

function Base.getproperty(e::Element_M, s::Symbol)
     s in keys(synonym_fields) && return getfield(e, synonym_fields[s])
     s in fieldnames(Element_M)  && return getfield(e, s)
     # in case it is a field of PeriodicTable elements only
     no = getfield(e, :atomic_number)
     e_pt = elements[no]
     return getfield(e_pt, s)
 end

Base.getindex(e::Elements_M, i::Integer) = e.bynumber[i]
Base.getindex(e::Elements_M, i::AbstractString) = e.byname[lowercase(i)]
Base.getindex(e::Elements_M, i::Symbol) = e.bysymbol[i]
Base.getindex(e::Elements_M, v::AbstractVector) = Element_M[e[i] for i in v]
Base.haskey(e::Elements_M, i::Integer) = haskey(e.bynumber, i)
Base.haskey(e::Elements_M, i::AbstractString) = haskey(e.byname, lowercase(i))
Base.haskey(e::Elements_M, i::Symbol) = haskey(e.bysymbol, i)
Base.get(e::Elements_M, i::Integer, default) = get(e.bynumber, i, default)
Base.get(e::Elements_M, i::AbstractString, default) = get(e.byname, lowercase(i), default)
Base.get(e::Elements_M, i::Symbol, default) = get(e.bysymbol, i, default)

# support iterating over Elements_M
Base.eltype(e::Elements_M) = Element_M
Base.length(e::Elements_M) = length(e.data)
Base.iterate(e::Elements_M, state...) = iterate(e.data, state...)
