elements_dbfile = "./data/elements.db"
edb = SQLite.DB(elements_dbfile)
tbls = SQLite.tables(edb)
tblnames = [t.name for t in tbls]

dfs = (; [Symbol(tname) => (DBInterface.execute(edb, "SELECT * FROM $tname") |> DataFrame) for tname in tblnames]...)
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

function col2unitful!(df, lb, u)
    lbs = string(lb)
    @assert string(lb) in names(df)
    lb_old = Symbol("$(lbs)_old")
    rename!(df, lb =>lb_old)
    insertcols!(df, lb=>(df[:, lb_old]*u))
    select!(df, Not(lb_old))
    return nothing
end

function df2unitful!(df, fu_dict)
    is =intersect( Symbol.(names(df)), keys(fu_dict))
    for l in is
        col2unitful!(df, l, fu_dict[l])
    end
    return nothing
end

# df2unitful!(els, f_units)

cnames = names(els) # 70-element Vector{String}: "annotation"...
ctypes =  eltype.(eachcol(els)) # 70-element Vector{Type}:  String...
vs = values.(eachrow(els))


make_struct("Element_M", cnames, ctypes)

const ELEMENTS_M = inst_elements(vs)

export Element_M, ELEMENTS_M

export cnames, ctypes, vs #, make_struct
