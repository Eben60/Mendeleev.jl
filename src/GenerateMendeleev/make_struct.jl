# https://github.com/PainterQubits/Unitful.jl/issues/385
# quantity(FloatType, unit) = Quantity{FloatType, dimension(unit), typeof(unit)}


function make_where(fts, Ts)
    w = ["$t :: $ft" for (t, ft) in zip(Ts, fts)]
    w = join(w, ", ")
    return "{$w}"
end

function make_struct(sname, fnames, ftypes, create=false)

    sname = string(sname)
    length(fnames) != length(ftypes) && throw(ArgumentError("inequal length of fnames and ftypes vectors"))

    fnames = fnames .|> string
    Ts = ["T$i" for i in eachindex(fnames)]
    # w = make_where(ftypes, Ts)
    s_type = "$sname"
    nmtp = Meta.parse(s_type)
    xs = ["$f::$ft" for (f,ft) in zip(fnames, ftypes)]
    x = Meta.parse.(xs)
    if create
        @eval begin
            struct $(nmtp)
                $(x...)
            end
        end
    end
    return (;s_type, xs)
end

function write_struct_jl(fl, descr)
    open(fl, "w") do io
        println(io, "# this is computer generated file - better not edit")
        println(io)
        println(io, "struct $(descr.s_type)")
        for f in descr.xs
            println(io, "    $f")
        end
        println(io, "end")
    end
end
