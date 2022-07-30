module IMP

using SQLite, DataFrames, PeriodicTable, Unitful, Tables
using JSONTables
using Scratch, Pkg.TOML

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


function inst_elements(xs)
    e = Element_M[]
    for x in xs
        push!(e, Element_M(x...))
    end
    return e
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

dfs = read_db_tables(elements_dbfile)

els = dfs.elements

# replace series_id by series string
ser = dfs.series
# select!(ser, :id, :name)
sort(ser, :name)

seriesnames = ["Nonmetals", "Noble gases", "Alkali metals", "Alkaline earth metals",
                "Metalloids", "Halogens", "Poor metals", "Transition metals",
                "Lanthanides", "Actinides"]
@assert seriesnames == ser.name

#
# serbyid(id) = ser[id, :name]
# select!(els, :series_id => :series, :)

groups = dfs.groups
sort!(groups, :group_id)

function grname(symbol, name)
    isempty(name) && return symbol
    return "$symbol ($name)"
end

struct Group_M
    symbol::String
    name::String
end

grouplist = [Group_M(g.symbol, g.name) for g in Tables.rowtable(groups)]


end
