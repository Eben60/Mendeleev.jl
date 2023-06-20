# function make_ustring(k, val, u_dic)
#     if  haskey(u_dic, k)
#         ismissing(val) && return ""
#         s = string(u_dic[k])
#         us = "u\"$s\""
#         return us
#     else
#         return ""
#     end
# end

# function f2repr(k, val, u_dic)
#     (val isa Bool) && return string(val)
#     (val isa Symbol) && return ":$(string(val))"
#     (val isa AbstractString) && return "\"$(escape_string(val))\""
#     return "$val$(make_ustring(k, val, u_dic))"
# end

# function row2tup_line(r::T, u_dic) where T <: NamedTuple
#     vs = [f2repr(k, r[k], u_dic) for k in keys(r)]
#     s = join(vs, ", \n")
#     return "($s)"
# end

# function make_static_data(fl, rs, u_dic)
#     open(fl, "w") do io
#         println(io, "# this is computer generated file - better not edit")
#         println(io)
#         println(io, "els_data = [")
#         for r in rs
#             l = row2tup_line(r, u_dic)
#             println(io, "$l,")
#         end
#         println(io, "]")
#     end
#     return nothing
# end


function make_oxstates_data(fl, els_data)
    open(fl, "w") do io
        oxstates = alloxstates(els_data)
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

function make_screening_data(fl, els_data)
    (;scr) = els_data
    open(fl, "w") do io
        screenings = getscreenings(scr)
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

function print_ioniz_energies(io, atomic_number, ion)
    ie = ionizenergies(atomic_number, ion)
    if ismissing(ie)
        println(io, "    $atomic_number => missing,")
    else
        en_strings = join(string.(ie), ", ")
        println(io, "    $atomic_number => [$en_strings],")
    end
    return nothing
end

function make_ionization_data(fl, els_data)
    (;ion ) = els_data
    open(fl, "w") do io
        println(io, "# this is computer generated file - better not edit")
        println(io)
        println(io, "const ionization_data = Dict{Int64, Union{Missing, Vector{Union{Missing, Float64}}}}(")
        for atomic_number in 1:els_data.last_no
            print_ioniz_energies(io, atomic_number, ion)
        end
        println(io, ")")
    end
    return nothing
end
