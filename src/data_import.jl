elements_dbfile = "./data/elements.db"
edb = SQLite.DB(elements_dbfile)
tbls = SQLite.tables(edb)
tblnames = [t.name for t in tbls]

dfs = (; [Symbol(tname) => (DBInterface.execute(edb, "SELECT * FROM $tname") |> DataFrame) for tname in tblnames]...)
els = dfs.elements
sort!(els, :atomic_number)

cnames = names(els) # 70-element Vector{String}: "annotation"...
ctypes =  eltype.(eachcol(els)) # 70-element Vector{Type}:  String...
vs = values.(eachrow(els))

# programmatically define struct named Element_M with given field names and types
make_struct("Element_M", cnames, ctypes)

# const ELEMENTS_M = [Element_M(v...) for v in vs] # takes as long as 90s on my computer

function inst_elements(xs)
    e = Element_M[]
    for x in xs
        push!(e, Element_M(x...))
    end
    return e
end

const ELEMENTS_M = inst_elements(vs)
