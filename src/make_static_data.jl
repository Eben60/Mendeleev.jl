function make_ustring(k, val, u_dic)
    if k in keys(u_dic)
        ismissing(val) && return ""
        s = string(u_dic[k])
        us = "u\"$s\""
        return us
    else
        return ""
    end
end

function f2repr(k, val, u_dic)
    (val isa Bool) && return string(val)
    (val isa Symbol) && return ":$(string(val))"
    (val isa AbstractString) && return "\"$(escape_string(val))\""
    return "$val$(make_ustring(k, val, u_dic))"
end

function row2tup_line(r::T, u_dic) where T <: NamedTuple
    vs = [f2repr(k, r[k], u_dic) for k in keys(r)]
    s = join(vs, ", \n")
    return "($s)"
end

function make_static_data(fl, rs, u_dic)
    open(fl, "w") do io
        println(io, "# this is computer generated file - better not edit")
        println(io)
        println(io, "els_data = [")
        for r in rs
            l = row2tup_line(r, u_dic)
            println(io, "$l,")
        end
        println(io, "]")
    end
    return nothing
end

function make_oxstates_data(fl)
    open(fl, "w") do io
        oxstates = alloxstates()
        println(io, "# this is computer generated file - better not edit")
        println(io)
        println(io, "const oxistates_data = Dict(")
        ks = sort(collect(keys(oxstates)))
        for k in ks
            states = oxstates[k]
            println(io, "    $k => $(oxstates[k]), ")
        end
        println(io, ")")
    end
    return nothing
end

function print_atom_screenings(io, d)
    atomic_number = d[1][1]
    println(io, "$atomic_number => ScreenConstants([")
    for t in d
        println(io, "    $t ,")
    end
    println(io, "]),")
end

function make_screening_data(fl)
    open(fl, "w") do io
        screenings = getscreenings()
        println(io, "# this is computer generated file - better not edit")
        println(io)
        println(io, "const screenings_data = Dict(")
        for sc in screenings
            print_atom_screenings(io, sc)
        end
        println(io, ")")
    end
    return nothing
end
