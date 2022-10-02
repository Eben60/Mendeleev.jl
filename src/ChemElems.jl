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

"""
    ChemElems
This struct is a contained for elements and provides access by number, symbol, or name. It is not exported.
"""
struct ChemElems
    data::Vector{ChemElem}
    bynumber::Dict{Int, Int}
    byname::Dict{String, Int}
    bysymbol::Dict{Symbol, Int}
    ChemElems(data::Vector{ChemElem}) = new(
        sortifneed!(data), # data should already be pre-sorted, thus we can save a couple of seconds here

        Dict{Int, Int}(data[i].atomic_number=>i for i in eachindex(data)),
        Dict{String, Int}(lowercase(data[i].name)=>i for i in eachindex(data)),
        Dict{Symbol, Int}(Symbol(data[i].symbol)=>i for i in eachindex(data))
        )
end
