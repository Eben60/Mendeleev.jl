
function make_struct(sname, fnames, ftypes)

    function make_where(fts, Ts)
        w = ["$t <: $ft" for (t, ft) in zip(Ts, fts)]
        w = join(w, ", ")
        return "{$w}"
    end

    sname = string(sname)
    length(fnames) != length(ftypes) && throw(ArgumentError("inequal length of fnames and ftypes vectors"))
    ftypes = ftypes .|> Symbol .|> string
    fnames = fnames .|> string
    Ts = ["T$i" for i in eachindex(fnames)]
    w = make_where(ftypes, Ts)
    nmtp = Meta.parse("$sname$w")
    xs = ["$f::$t" for (f,t) in zip(fnames, Ts)]
    x = Meta.parse.(xs)

    @eval begin
        struct $(nmtp)
            $(x...)
        end
    end

    return nothing
end
