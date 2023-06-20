using CSV, DataFrames, JSON3

fl_in = normpath(@__DIR__, "../data/electronegativities.csv")
fl_out = normpath(@__DIR__, "../data/eneg_data.jl")
# stat(fl)

df = CSV.read(fl_in, DataFrame) # ; kwargs

# df0 = copy(df)

function nodoublenames(s_in)
    double = occursin('-', s_in) 
    !double && return (;double, s_in, s_out=s_in)
    return (;double, s_in, s_out=s_in[begin:findfirst('-', s_in)-1])
end

function unhyphenate!(df)
    for n in names(df)
        ndn = nodoublenames(n)
        if ndn.double
            rename!(df, ndn.s_in => ndn.s_out)
        end
    end
end

function strvec(v) 
    sv = [string(x) for x in v]
    sc = join(sv, ", ")
    return "[$sc]"
end
    

function make_eneg_data(fl, df)
    open(fl, "w") do io
        println(io, "# this is computer generated file - better not edit")
        println(io)
        println(io, "const eneg_data = (;")
        for nm in sort(names(df))
            println(io, "    $nm = $(strvec(df[!, nm])),")
        end
        println(io, ")")
    end
    return nothing
end

sort!(df, :atomic_number)
@assert df[!, :atomic_number] == 1:118
select!(df,  Not(["Li-Xue", "atomic_number"]))

unhyphenate!(df)
make_eneg_data(fl_out, df)

;