elements_src = joinpath(@__DIR__ , "../data/elements.db")
tmp_dir = @get_scratch!("mendeleev_files")

elements_dbfile = joinpath(tmp_dir, "mendeleev-elements.db")

if !isfile(elements_dbfile)
    cp(elements_src, elements_dbfile)
end

function read_db_tables(dbfile)
    edb = SQLite.DB(dbfile)
    tbls = SQLite.tables(edb)
    tblnames = [t.name for t in tbls]
    dfs = (; [Symbol(tname) => (DBInterface.execute(edb, "SELECT * FROM $tname") |> DataFrame) for tname in tblnames]...)
    return dfs
end

dfs = read_db_tables(elements_dbfile)

els = dfs.elements
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


# df2unitful!(els, f_units)
sortcols!(els)

ctypes = coltypes(eachcol(els), fu1)

cnames = names(els) # 70-element Vector{String}: "annotation"...
vs = NamedTuple.(eachrow(els))


# (;type=nmtp, fields=x)
s_def_text = make_struct("Element_M", cnames, ctypes)

write_struct_jl(struct_fl, s_def_text)

#
# export Element_M, ELEMENTS_M
#
# export cnames, ctypes, vs #, make_struct
