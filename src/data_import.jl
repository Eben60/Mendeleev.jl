elements_src = joinpath(@__DIR__ , "../data/elements.db")
tmp_dir = @get_scratch!("mendeleev_files")

elements_dbfile = joinpath(tmp_dir, "mendeleev-elements.db")
chembook_jsonfile = joinpath(@__DIR__ , "../data/el_chembook.json")

if !isfile(elements_dbfile)
    cp(elements_src, elements_dbfile)
end

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

const dfs = read_db_tables(elements_dbfile)
dfcb = readdf(chembook_jsonfile)

els = dfs.elements
els = rightjoin(dfcb, els, on = :atomic_number)
els = rightjoin(dfpt, els, on = :atomic_number)

sort!(els, :atomic_number)

# programmatically define struct named Element_M with given field names and types

# const ELEMENTS_M = [Element_M(v...) for v in vs] # takes as long as 90s on my computer

function inst_elements(xs)
    e = Element_M[]
    for x in xs
        push!(e, Element_M(x...))
    end
    return e
end

# function col2unitful!(df, lbl, u)
#     replacecol!(df, lbl, *, u)
#     return nothing
# end
#
# function df2unitful!(df, fu_dict)
#     is =intersect(Symbol.(names(df)), keys(fu_dict))
#     for l in is
#         col2unitful!(df, l, fu_dict[l])
#     end
#     return nothing
# end

function coltypes(cols, udict)
    nms = Symbol.(names(cols))
    tps = String[]

    for i in 1:length(nms)
        n = nms[i]
        if n in keys(udict)
            tp = "typeof(1.0*$(udict[n]))"
            if eltype(cols[i]) isa Union
                tp = "Union{Missing, $tp}"
            end
        else
            tp = eltype(cols[i]) |> Symbol |> string
        end
        push!(tps, tp)
    end
    return tps
end

function sortcols!(df)
    nms = sort!(collect(names(df)))
    select!(df, nms...)
    return nothing
end

# boolean columns are sometimes encoded as integer {0, 1} and sometimes as {missing, 1} - let's convert them to Bool
select!(els, [:is_monoisotopic, :is_radioactive] .=> ByRow(x -> !(ismissing(x) || x == 0)), renamecols=false, :)
# @show els[1:3, :is_monoisotopic]
# @show els[81:84, :is_radioactive]


select!(els, :symbol => ByRow(x -> Symbol.(x)), renamecols=false, :)
# @show els[1:3, :symbol]


ser = dfs.series
# sort(ser, :name)
# check if series names still the same es ever
@assert collect(seriesnames) == ser.name
# rename column; see getproperty(...., :series)
rename!(els, :series_id => :series)

groups = dfs.groups
sort!(groups, :group_id)
grouplist = [Group_M(g.symbol, g.name) for g in Tables.rowtable(groups)]
# check if groups still the same es ever
@assert collect(groups_m) == grouplist
# rename column; see getproperty(...., :group)
rename!(els, :group_id => :group)

function getoxstates(no)
    ox = dfs.oxidationstates
    oxstates = ox[ox.atomic_number.==no , :oxidation_state]
    (isempty(oxstates) || ismissing(oxstates[1])) && return missing # Int[]
    return [Int(x) for x in oxstates]
end

function alloxstates()
    return Dict([no=>getoxstates(no) for no in els.atomic_number])
end









# df2unitful!(els, f_units)
sortcols!(els)

ctypes = coltypes(eachcol(els), fu1)

cnames = names(els) # 70-element Vector{String}: "annotation"...
vs = NamedTuple.(eachrow(els))


# (;type=nmtp, fields=x)
s_def_text = make_struct("Element_M", cnames, ctypes)
