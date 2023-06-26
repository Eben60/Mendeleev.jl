using DataFrames

function elsym(atomic_number, data)
    els = data.els
    el = filter(:atomic_number => isequal(atomic_number), els)
    return el[1, "symbol"]
end

function addelem(data)
    elsy(atomic_number) = elsym(atomic_number, data)
    pt = data.dfs.phasetransitions
    return  transform(pt, :atomic_number => ByRow(elsy) => :symbol)
end

function allo(data)
    pt = copy(data.dfs.phasetransitions)
    pt.allotropes = Vector{Any}(missing, nrow(pt))
    pt.leave_this_row .= true

    gdf = groupby(pt, :atomic_number)
    default_allotropes = Dict([6=>"graphite", 15=>"white", 16=>"rhombic", 34=>"gray", 50=>"white"])

    # allotropes for only 5 elements : C, P, S, Se, Sn
    # C - graphite # 6
    # P - white # 15
    # S - rhombic #16
    # Se - gray # 34
    # Sn - white #50
    allogdf = [g for g in gdf if g[1, :atomic_number] in keys(default_allotropes)]

    for g in allogdf
        allotropes = collect(g[!, :allotrope])
        g[!, :allotropes] .= allotropes
        for i in 1:nrow(g)
            g[i, :leave_this_row] = g[i, :allotrope] == default_allotropes[g[i, :atomic_number]]
        end
        @show g[!, :allotropes] 
    end

    subset!(pt, :leave_this_row)
    select!(pt, Not(:leave_this_row))
    rename!(pt, :allotrope => :default_allotrope)

    gdf = groupby(pt, :atomic_number)
    allogdf = [g for g in gdf if g[1, :atomic_number] in keys(default_allotropes)]
    return (;pt, gdf, allogdf)

end
;   
