function sortifneed!(data)
    # sorted = issorted(data; by=d->d.atomic_number) # my code is faster
    sorted = true
    nᵢ = data[1].atomic_number
    for i in 2:lastindex(data)
        n = data[i].atomic_number
        if n <= nᵢ
            sorted = false
            @show "unsorted at pos. $i"
            break
        end
        nᵢ = n
    end

    if !sorted
        sort!(data; by=d->d.atomic_number)
    end
    return data
end

struct Elements_M
    data::Vector{Element_M}
    bynumber::Dict{Int, Int}
    byname::Dict{String, Int}
    bysymbol::Dict{Symbol, Int}
    Elements_M(data::Vector{Element_M}) = new(
        sortifneed!(data), # data should already be pre-sorted, thus we can save a couple of seconds here
        # sort!(data; by=d->d.atomic_number),
        # data,
        Dict{Int, Int}(data[i].atomic_number=>i for i in eachindex(data)),
        Dict{String, Int}(lowercase(data[i].name)=>i for i in eachindex(data)),
        Dict{Symbol, Int}(Symbol(data[i].symbol)=>i for i in eachindex(data))
        )
end
