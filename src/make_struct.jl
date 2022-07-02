# https://github.com/PainterQubits/Unitful.jl/issues/385
# quantity(FloatType, unit) = Quantity{FloatType, dimension(unit), typeof(unit)}


function make_where(fts, Ts)
    w = ["$t <: $ft" for (t, ft) in zip(Ts, fts)]
    w = join(w, ", ")
    return "{$w}"
end

function make_struct(sname, fnames, ftypes::FT) where FT <: Vector{T} where T<:Type
    sname = string(sname)
    length(fnames) != length(ftypes) && throw(ArgumentError("inequal length of fnames and ftypes vectors"))
    fts = ftypes .|> Symbol .|> string
    fnames = fnames .|> string
    Ts = ["T$i" for i in eachindex(fnames)]
    w = make_where(fts, Ts)

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

# # # WIP!
function make_struct(sname, fnames, ftypes) # where FT <: Vector{T1} where T1 <: Vector{T} where T

    sname = string(sname)
    length(fnames) != length(ftypes) && throw(ArgumentError("inequal length of fnames and ftypes vectors"))

    #ftypes = ftypes .|> Symbol .|> string

    fts = ["eltype(\$ftypes[$i])" for i in 1:length(ftypes)]
    @show fts[1:2]
    fnames = fnames .|> string
    Ts = ["T$i" for i in eachindex(fnames)]
    w = make_where(fts, Ts)

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




ms = make_struct
