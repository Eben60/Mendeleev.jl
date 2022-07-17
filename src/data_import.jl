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

function col2unitful!(df, lbl, u)
    replacecol!(df, lbl, *, u)
    return nothing
end

function df2unitful!(df, fu_dict)
    is =intersect(Symbol.(names(df)), keys(fu_dict))
    for l in is
        col2unitful!(df, l, fu_dict[l])
    end
    return nothing
end

function replacecol!(df, lbl, f, args...)
    newcol = f(df[!, lbl], args...)
    select!(df, Not(lbl))
    insertcols!(df, lbl=>newcol)
    return nothing
end

function replacecol!(df, lbls::Vector{Symbol}, f, args...)
    for lbl in lbls
        replacecol!(df, lbl, f, args...)
    end
    return nothing
end

function miss2false(v)
    bv = ones(Bool, length(v))
    for i in 1:lastindex(v)
        if ismissing(v[i]) || v[i] == 0
            bv[i] = false
        end
    end
    return bv
end


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

replacecol!(els, [:is_monoisotopic, :is_radioactive], miss2false)
# @show els[1:3, :is_monoisotopic]
replacecol!(els, :symbol, x -> Symbol.(x))
# @show els[1:3, :symbol]


df2unitful!(els, f_units)
sortcols!(els)

ctypes = coltypes(eachcol(els), fu1)

cnames = names(els) # 70-element Vector{String}: "annotation"...
vs = values.(eachrow(els))


# (;type=nmtp, fields=x)
s_def_text = make_struct("Element_M", cnames, ctypes)

write_struct_jl(struct_fl, s_def_text)

#
# export Element_M, ELEMENTS_M
#
# export cnames, ctypes, vs #, make_struct
