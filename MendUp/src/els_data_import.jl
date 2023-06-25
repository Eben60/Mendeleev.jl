
function readdf(jfile)
    jsource = open(jfile) do file
       read(file, String)
    end
    return DataFrame(jsontable(jsource))
end

function read_db_tables(dbfile)
    edb = SQLite.DB(dbfile)
    tbls = SQLite.tables(edb)
    tblnames = [t.name for t in tbls]
    dfs = (; [Symbol(tname) => (DBInterface.execute(edb, "SELECT * FROM $tname") |> DataFrame) for tname in tblnames]...)
    return dfs
end

function write_dflayout(fl, tabledict)
    open(fl, "w") do io
        println(io, "# this is computer generated file - better not edit")
        println(io)
        println(io, "df_layout = Dict{Symbol, Vector{String}}(")
        for (k, nms) in pairs(tabledict)
            println(io, "    :$k => [")
            # nms = sortednames(dfs[k])
            for v in nms
                println(io, "    \"$v\",")
            end
            println(io, "    ],")
            # symb = df[n, :symbol]
            # nm = df[n, :name]
            # !ismissing(symb) && println(io, "    ChemElem($n, \"$nm\", :$symb),")
        end
        println(io, ")")
    end
    return nothing 
end

function sortcols!(df)
    nms = sort!(collect(names(df)))
    select!(df, nms...)
    return nothing
end

function make_data_dict(df, nms)
    d = Dict{Symbol, Vector{Any}}()
    for nm in nms
        v = df[!, nm]
        push!(d, nm => v)
    end
    return d
end


function to_str(x)
    x = (ismissing(x) || x == "") ? missing : x
    x isa AbstractString && return "\"$(escape_string(x))\""
    x isa AbstractFloat && return string(round(x; sigdigits=13))
    return string(x)
end

# function printtuple(io, v)
#     println(io, "    (")
#     for (n, x) in pairs(v)
#          println(io, "    $(to_str(x)) , # $(el_symbols[n])")
#     end
#     println(io, "    )")
# end

function printvector(io, v, el_symbols)
    println(io, "    [")
    for (n, x) in pairs(v)
         println(io, "    $(to_str(x)) , # $(el_symbols[n])")
    end
    println(io, "    ]")
end

function make_elements_data(fl, els_data)
    (;el_symbols, data_dict) = els_data
    data = data_dict
    nms = sort(collect(keys(data)))
    open(fl, "w") do io
        println(io, "# this is computer generated file - better not edit")
        println(io)
        println(io, "const elements_data = (; ")
        for nm in nms
            println(io, "    $nm = ")
            printvector(io, data[nm], el_symbols)
            println(io, "    ,")
        end
        println(io, ")")
    end
    return nothing
end


function make_chem_elements(fl, df)
    nums = df[!, :atomic_number]
    open(fl, "w") do io
        println(io, "# this is computer generated file - better not edit")
        println(io)
        println(io, "const chem_elements = ChemElems([")
        for n in nums
            symb = df[n, :symbol]
            nm = df[n, :name]
            !ismissing(symb) && println(io, "    ChemElem($n, \"$nm\", :$symb),")
        end
        println(io, "])")
    end
    return nothing
end

sortednames(nt::NamedTuple, to_omit) = sort(setdiff(keys(nt), to_omit))
sortednames(df::DataFrame) = sort(setdiff(names(df), ["id"]))


function set_allotropes!(pt)
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

    allogdf = [g for g in gdf if any(.! ismissing.(g[!, :allotrope]))]
    @show allogdf

    for g in allogdf
        allotropes = collect(g[!, :allotrope])
        g[!, :allotropes] .= Ref(allotropes)
        if g[1, :atomic_number] in keys(default_allotropes)
            for i in 1:nrow(g)
                g[i, :leave_this_row] = g[i, :allotrope] == default_allotropes[g[i, :atomic_number]]
            end
        else
            @assert nrow(g) == 1
        end
    end

    subset!(pt, :leave_this_row)
    select!(pt, Not(:leave_this_row))
    rename!(pt, :allotrope => :default_allotrope)
    return pt
end
;   


function els_data_import(dfpt, update_db ;paths=paths)
    (;elements_src, elements_dbfile, chembook_jsonfile, db_struct_new_fl, db_struct_prev_fl) = paths
    if update_db == :restore 
        cp(elements_src, elements_dbfile; force=true)
        cp(db_struct_prev_fl, db_struct_new_fl; force=true)
        error("Restored db and `db_struct_new.jl`, terminating program")
    elseif (!isfile(elements_dbfile) | update_db)
        elements_src = get_mend_dbfile()
        cp(elements_src, elements_dbfile; force=true)
        println("updated database cached file")
    end
    dfs = read_db_tables(elements_dbfile)
    allnames = vcat([names(x) for x in dfs]...)

    tablenames = sortednames(dfs, [:alembic_version,])
    tabledict = Dict{Symbol, Vector{String}}()


    for tn in tablenames 
        df = dfs[tn]
        dfnames = sortednames(df)
        push!(tabledict, tn=>dfnames)
    end

    include(db_struct_prev_fl) # previous df_layout 
    
    if !(df_layout == tabledict)
        if update_db == true
            write_dflayout(db_struct_new_fl, tabledict)
            println("wrote the current db layout into file \"db_struct_new.jl\"")
        end
        error("database layout changed! - please re-check")
    end

    dfcb = readdf(chembook_jsonfile)

    pht = copy(dfs.phasetransitions)
    set_allotropes!(pht)

    els = dfs.elements
    els = rightjoin(dfcb, els, on = :atomic_number)
    els = rightjoin(dfpt, els, on = :atomic_number)
    els = rightjoin(pht, els, on = :atomic_number)

    select!(els, Not([:en_allen, :en_ghosh, :en_pauling])) # all electronegativies treated separately
    sort!(els, :atomic_number)

    last_no = maximum(els[!, :atomic_number])

    # boolean columns are sometimes encoded as integer {0, 1} and sometimes as {missing, 1} - let's convert them to Bool
    select!(els, [:is_monoisotopic, :is_radioactive] .=> ByRow(x -> !(ismissing(x) || x == 0)), renamecols=false, :)
    # @show els[1:3, :is_monoisotopic]
    # @show els[81:84, :is_radioactive]


    select!(els, :symbol => ByRow(x -> Symbol.(x)), renamecols=false, :)
    # @show els[1:3, :symbol]

    # should new elements be discovered, guarantee there are rows for all atomic numbers (including for missing elements)
    els_range = DataFrame(atomic_number = 1:last_no)
    els = rightjoin(els, els_range, on = :atomic_number)

    mainfields = [:atomic_number, :name, :symbol]
    allfields = Symbol.(names(els))
    datafields = sort(setdiff(allfields, mainfields))

    el_symbols = string.(els[!, :symbol])
    data_dict = make_data_dict(els, datafields)
    return (;last_no, el_symbols, data_dict, dfs, els, pht)
end