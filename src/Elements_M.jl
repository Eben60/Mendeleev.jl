struct Elements_M
    data::Vector{Element_M}
    bynumber::Dict{Int, Int}
    byname::Dict{String, Int}
    bysymbol::Dict{Symbol, Int}
    Elements_M(data::Vector{Element_M}) = new(
        sort!(data, by=d->d.atomic_number),
        Dict{Int, Int}(data[i].atomic_number=>i for i in eachindex(data)),
        Dict{String, Int}(lowercase(data[i].name)=>i for i in eachindex(data)),
        Dict{Symbol, Int}(Symbol(data[i].symbol)=>i for i in eachindex(data))
        )
end
