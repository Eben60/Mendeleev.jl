t0 = now()
elements_dbfile = "./data/elements.db"
edb = SQLite.DB(elements_dbfile)
tbls = SQLite.tables(edb)
tblnames = [t.name for t in tbls]

dfs = (; [Symbol(tname) => (DBInterface.execute(edb, "SELECT * FROM $tname") |> DataFrame) for tname in tblnames]...)
els = dfs.elements
sort!(els, :atomic_number)

cnames = names(els) # 70-element Vector{String}: "annotation"...
ctypes =  eltype.(eachcol(els)) # 70-element Vector{Type}:  String...
const vs = values.(eachrow(els))

# programmatically define struct named Element_M with given field names and types

# const ELEMENTS_M = [Element_M(v...) for v in vs] # takes as long as 90s on my compute

function inst_elements(xs)
    e = Element_M[]
    for x in xs
        push!(e, Element_M(x...))
    end
    return e
end

t1 = now()
const mtypes = map(maintype, ctypes)
const unvs = [unmiss.(v, mtypes) for v in vs]

make_struct("Element_M", cnames, ctypes)

const ELEMENTS_M = inst_elements(unvs)
t2 = now()
dt1 = t1-t0
dt2 = t2-t1
println(dt1+dt2)
@show dt1 dt2
f=4
