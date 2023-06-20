function elem_isotopes(no, df)
    nos = Set(df[!, :atomic_number])
    !(no in nos) && return missing
    el_data = subset(df, :atomic_number => (x -> x .== no )) |> rowtable .|> Tuple .|> collect .|> round_pos
    return el_data
end

function isot_string(x)
    s = string.(x)
    j = join(s, ", ")
    return "Isotope($j)"
end

function isots_string(x)
    ismissing(x) && return "missing"
    j = join(isot_string.(x), ", ")
    return "Isotopes([$j])"
end


function make_isotopes_data(fl, d_isot, els_data)
    open(fl, "w") do io
        println(io, "# this is computer generated file - better not edit")
        println(io)
        println(io, "const isotopes_data = Dict{Int64, Union{Missing, Isotopes}}(")
        for no in 1:els_data.last_no
            println(io, "    $no => ", isots_string(d_isot[no]), ",")
        end
        println(io, ")")
    end
    return nothing
end

el(x) = elements[x] # to enable broadcasting over x
sym(x) = string(el(x).symbol)


function isotopes(els_data)
    (;dfs) = els_data
    isot = dfs.isotopes
    i4 = select(isot, :id, :atomic_number, :atomic_number => (x -> sym.(x))  => :sym, :mass_number, :mass, :abundance; renamecols=false)
    i4s = subset(i4, :abundance => (x -> .!(ismissing.(x) .| iszero.(x))))[!, [:atomic_number, :mass_number, :mass, :abundance]]
    d_isot = Dict(n => elem_isotopes(n, i4s) for n in 1:els_data.last_no)
    return d_isot
end