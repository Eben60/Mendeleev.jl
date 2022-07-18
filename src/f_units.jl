

function un_u(fud)
    fu1 = Dict{Symbol, String}()
    for k in keys(fud)
        s = string(fud[k])
        if occursin(" ", s)
            s = replace(s, " " => "*")
        end
        fu1[k] = "u\"$s\""
    end
    return fu1
end


fu1 = un_u(f_units)

# function maintype(t)
#     !(t isa Union) && return t
#     ts = Base.uniontypes(t)
#     d=setdiff(ts, [Missing])
#     @assert length(d)==1
#     return collect(d)[1]
# end
